require_relative './game_state'
require_relative './game_presenter/console_io'
require_relative './messages'
require_relative './game_rules'
require_relative './validator'

class Game
    include Validator
    include Messages
    include GameRules

    attr_accessor :game_state, :game_presenter, :status

    STARTING_INVALID_VALUE = -1

    def initialize(game_presenter: ConsoleIO.new, board_size:, player_2:)
        @game_presenter = game_presenter
        @game_state = GameState.new(
            player_2: player_2,
            board_size: board_size
        )
        @status = :play
    end

    def play
        while status == :play
            turn
        end
        game_presenter.output_message(win_msg(game_state.current_player.token)) if status == :win
        game_presenter.output_message(tie_msg) if status == :tie 
    end

    def move
        game_state.current_player.move(
            board: game_state.board, 
            presenter: game_presenter,
        )
    end

    def update_game_status
        @status = :win if win?(board: game_state.board) 
        @status = :tie if tie?(board: game_state.board) 
    end

    def turn
        input = STARTING_INVALID_VALUE

        input = move while !position_valid?(input: input, board: game_state.board)
        game_state.update(position: input.to_i)
        update_game_status
        game_state.switch_players if status == :play
    end
end

