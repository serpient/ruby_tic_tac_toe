require_relative '../game'

module Reinitializer
    extend self
    
    def generate(game_data:)
        @game = Game.new(
            board_size: game_data.fetch(:board_size),
            player_2: game_data.fetch(:player_2),
            game_mode: game_data.fetch(:game_mode),
        )
        set_status(game_data)
        set_board_position(game_data)
        set_current_player(game_data)
        set_lite_3_data(game_data) if (game.game_state.game_mode.is_a?(Lite3))
        game
    end

    private
    attr_accessor :game

    def set_status(game_data)
        game.status = game_data.fetch(:status)
    end

    def set_board_position(game_data)
        game.game_state.board.positions = game_data.fetch(:board_positions)
    end

    def set_current_player(game_data)
        game.game_state.current_player = game_data.fetch(:current_player_token) == :X ? game.game_state.player_1 : game.game_state.player_2
    end

    def set_lite_3_data(game_data)
        game.game_state.game_mode.player_1_moves = game_data.fetch(:player_1_moves) 
        game.game_state.game_mode.player_2_moves = game_data.fetch(:player_2_moves) 
    end
end 