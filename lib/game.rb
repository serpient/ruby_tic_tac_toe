require_relative '../lib/game_state'
require_relative '../lib/game_presenter'
require_relative '../lib/messages'
require_relative '../lib/game_setting'
require_relative '../lib/game_rules'

class Game
    include Validator
    include Messages
    include GameRules

    attr_accessor :game_state, :game_presenter, :status

    def initialize(game_presenter: ConsoleIO.new, board_size:, player_2:)
        @game_presenter = game_presenter
        @game_state = GameState.new(
            player_2: player_2,
            board_size: board_size
        )
        @status = :play
    end

    def play
        4.times { turn() }
        puts "#{game_state.board.positions}"
    end

    def move()
        game_state.current_player.move(board: game_state.board, presenter: game_presenter)
    end

    def turn
        input = nil
        while !position_valid?(input: input, board: game_state.board)
            game_presenter.output_message(choose_position)
            input = move(presenter: game_presenter)
        end

        game_state.update(position: input.to_i)
        
        @status = :win if win?(board: game_state.board)
        @stats = :tie if tie?(board: game_state.board)

        game_state.switch_players
        return
    end
end

