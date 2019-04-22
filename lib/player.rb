class Player
    attr_accessor :player, :token

    def initialize(player:, token:) 
        @player = player
        @token = token
    end

    def move(board:)
        player.move(board: board)
    end
end

class Human 
    def move(board:)
        return 0
    end
end

class Computer 
    def move(board:)
        board.empty_positions().sample()
    end
end