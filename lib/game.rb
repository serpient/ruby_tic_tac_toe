require_relative '../lib/game_state'
require_relative '../lib/game_presenter'
require_relative '../lib/messages'
require_relative '../lib/game_rules'
require_relative '../lib/validator'

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

    def turn
        input = STARTING_INVALID_VALUE

        input = move while !position_valid?(input: input, board: game_state.board)

        game_state.update(position: input.to_i)

        if win?(board: game_state.board) 
            @status = :win
        elsif tie?(board: game_state.board)
            @status = :tie 
        else
            game_state.switch_players
        end
    end
end

