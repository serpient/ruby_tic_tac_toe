require_relative '../game'

module Initializer
    extend self
    
    def reinitialize(game_data:)
        Game.new(
            board_size: game_data[:board_size],
            player_2: game_data[:player_2]
        )
    end
end 