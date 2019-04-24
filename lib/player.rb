class Player
    attr_accessor :player, :token

    def initialize(player:, token:) 
        @player = player
        @token = token
    end

    def move(board:, presenter:)
        player.move(board: board, presenter: presenter)
    end
end

class Human 
    def move(board:, presenter:)
        presenter.get_input
    end
end

class Computer 
    def move(board:, presenter: )
        board.empty_positions.sample
    end
end

module PlayerType
    def human
        return "H"
    end

    def computer
        return "C"
    end
end