require_relative './game_state'
require_relative './game_io/console_io'
require_relative './messages'
require_relative './game_rules'
require_relative './validator'
require_relative './board_presenter/board_presenter'
require_relative './board_presenter/string_board'

class Game
    include Validator
    include Messages
    include GameRules

    attr_accessor :game_state, :status

    def initialize(game_io: ConsoleIO.new, board_size:, player_2:, board_presenter: StringBoard.new)
        @game_io = game_io
        @game_state = GameState.new(
            player_2: player_2,
            board_size: board_size
        )
        @status = :play
        @board_presenter = BoardPresenter.new(presenter: board_presenter)
    end

    def play
        while status == :play
            output_board
            position = get_valid_move(board: game_state.board, presenter: game_io)
            board = update_board(input: position)
            update_game_status(board: board)
            game_state.switch_players if status == :play
        end
        output_board
        output_win if status == :win
        output_tie if status == :tie 
    end

    private
    attr_accessor :game_io, :board_presenter

    def output_board
        game_io.clear
        board_presenter.generate(board: game_state.board)
        game_io.output_message(board_presenter.output)
    end

    def get_valid_move(board:, presenter:)
        input = -1
        input = game_state.current_player.move(board: board, presenter: presenter) while !Validator.position_valid?(input: input, board: board)
        input
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
end

