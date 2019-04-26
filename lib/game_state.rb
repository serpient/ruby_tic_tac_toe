require_relative './token'
require_relative './player/player'
require_relative './player/human'
require_relative './player/computer'
require_relative './player/player_types'
require_relative './board'

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
        @player_1 = Player.new(player: get_player(player_1), token: player_x)
        @player_2 = Player.new(player: get_player(player_2), token: player_o)
        @current_player = @player_1
    end

    def switch_players
        @current_player = current_player == player_1 ? player_2 : player_1
    end

    def update(position:)
        board.update(position: position, token: current_player.token)
    end

    private
    def get_player(type)
        type == human ? Human.new() : Computer.new()
    end
end