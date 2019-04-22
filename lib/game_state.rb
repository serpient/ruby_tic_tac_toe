class GameState 
    attr_accessor :player_1, :player_2, :board, :current_player
    
    def initialize(
        player_1:,
        player_2:,
        board_size:
    )
        @player_1 = Player.new(player: player_1, token: :hero)
        @player_2 = Player.new(player: player_2, token: :opponent)
        @board = Board.new(size: board_size)
        @current_player = @player_1
    end

    def switch_players()
        @current_player = current_player == player_1 ? player_2 : player_1
    end
end