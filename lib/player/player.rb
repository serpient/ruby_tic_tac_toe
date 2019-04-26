require_relative '../messages'

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

    def get_valid_move(board:, presenter:)
        player.get_valid_move(board: board, presenter: presenter)
    end
end