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

    attr_accessor :game_state, :game_io, :status, :input, :board_presenter

    STARTING_INVALID_VALUE = -1

    def initialize(game_io: ConsoleIO.new, board_size:, player_2:, board_presenter: StringBoard.new())
        @game_io = game_io
        @game_state = GameState.new(
            player_2: player_2,
            board_size: board_size
        )
        @status = :play
        @board_presenter = board_presenter
    end

    def play
        while status == :play
            output_board
            take_turn
        end
        output_board
        output_win if status == :win
        output_tie if status == :tie 
    end

    def take_turn
        get_valid_move
        update_board
        update_game_status
        game_state.switch_players if status == :play
    end

    private
    def move
        game_state.current_player.move(
            board: game_state.board, 
            presenter: game_io,
        )
    end

    def output_board
        game_io.clear
        board_presenter.generate(board: game_state.board)
        game_io.output_message(board_presenter.output)
    end

    def get_valid_move
        input = STARTING_INVALID_VALUE
        input = move while !position_valid?(input: input, board: game_state.board)
        @input = input
    end

    def update_board
        game_state.update(position: input.to_i)
    end

    def update_game_status
        @status = :win if win?(board: game_state.board) 
        @status = :tie if tie?(board: game_state.board) 
    end

    def output_win
        game_io.output_message(win_msg(game_state.current_player.token))
    end

    def output_tie
        game_io.output_message(tie_msg) 
    end
end

