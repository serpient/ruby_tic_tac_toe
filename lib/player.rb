require_relative '../lib/messages'

class Player
    attr_accessor :player, :token

    def initialize(player:, token:) 
        @player = player
        @token = token
        player.token = token
    end

    def move(board:, presenter:)
        player.move(board: board, presenter: presenter)
    end
end

class Human 
    include Messages
    attr_accessor :token

    def move(board:, presenter:)
        presenter.output_message(choose_position(token))
        presenter.get_input
    end
end

class Computer 
    include Messages
    attr_accessor :token

    def move(board:, presenter:)
        position = board.empty_positions.sample
        presenter.output_message(computer_chooses(position, token))
        return position
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