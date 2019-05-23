require_relative './game_state'
require_relative './game_io/console_io'
require_relative './messages'
require_relative './game_rules'
require_relative './validator'
require_relative './input_type'
require_relative './board_presenter/board_presenter'
require_relative './board_presenter/string_board'
require_relative './game_mode/game_mode_types'
require_relative './persister/persister'
require_relative './repository/local'

class Game
    include Validator
    include Messages
    include GameRules
    include GameModeTypes
    include InputType

    attr_accessor :game_state, :status,  :board_presenter

    def initialize(
        game_io: ConsoleIO.new, 
        board_size:, player_2:, 
        board_presenter: StringBoard.new,
        game_mode: GameModeTypes::REGULAR_MODE
    )
        @game_io = game_io
        @game_state = GameState.new(
            player_2: player_2,
            board_size: board_size,
            game_mode: game_mode
        )
        @status = :play
        @board_presenter = BoardPresenter.new(presenter: board_presenter)
    end

    def play
        while status == :play
            output_board
            output_save_option
            input = get_valid_input(board: game_state.board, presenter: game_io)
            if input == InputType::SAVE
                @status = :save
            else
                board = update_board(input: input) 
                update_game_status(board: board)
                game_state.switch_players if status == :play
            end
        end
        output_board
        save_game if status == :save
        output_win if status == :win
        output_tie if status == :tie 
    end

    private
    attr_accessor :game_io

    def output_board
        game_io.clear
        board_presenter.generate(board: game_state.board)
        game_io.output_message(board_presenter.output)
    end

    def output_save_option
        game_io.output_message(Messages.output_save_option)
    end

    def get_valid_input(board:, presenter:)
        input = -1
        input = game_state.current_player.move(board: board, presenter: presenter) while input_not_valid(input: input, board: board) 
        input
    end

    def input_not_valid(input:, board:) 
        !Validator.position_valid?(input: input, board: board) && !Validator.save_game?(input: input)
    end

    def update_board(input:)
        game_state.update(position: input.to_i)
        game_state.board
    end

    def update_game_status(board:)
        @status = :win if GameRules.win?(board: board) 
        @status = :tie if GameRules.tie?(board: board) 
    end

    def output_win
        game_io.output_message(Messages.win(game_state.current_player.token))
    end

    def output_tie
        game_io.output_message(Messages.tie) 
    end

    def save_game
        repository_type = game_io.is_a?(ConsoleIO) ? Memory.new : Local.new
        at_exit do
            persister = Persister.new(repository_type: repository_type)
            persister.suspend(self)
            game_io.output_message(Messages.game_save)
        end
    end
end

