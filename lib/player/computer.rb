require_relative './player_types';

class Computer 
    attr_accessor :token

    def move(board:, presenter:)
        board.empty_positions.sample
    end

    def type
        PlayerType::COMPUTER
    end
end