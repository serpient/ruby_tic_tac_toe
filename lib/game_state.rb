require_relative './token'
require_relative '../lib/player'

class GameState 
    include Token
    include PlayerType
    attr_accessor :player_1, :player_2, :board, :current_player
    
    def initialize(
        player_1: human,
        player_2:,
        board_size:
    )
        @board = Board.new(size: board_size)
        @player_1 = Player.new(player: get_player(player_1).new(), token: hero)
        @player_2 = Player.new(player: get_player(player_2).new(), token: opponent)
        @current_player = @player_1
    end

    def switch_players
        @current_player = current_player == player_1 ? player_2 : player_1
    end

    def get_player(type)
        return type == human ? Human : Computer
    end
end