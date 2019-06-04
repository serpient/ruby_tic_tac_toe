class Player
    attr_accessor :player, :token

    def initialize(player:, token:) 
        @player = player
        @token = token
        player.token = token
    end

    def type
        player.type
    end

    def move(board:, presenter:)
        player.move(board: board, presenter: presenter)
    end
end