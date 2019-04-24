require_relative '../lib/player'

module Validator
    include PlayerType

    def position_valid?(input:, board:) 
        int = input.to_i
        return board_range_valid?(int,board) && board.position_empty?(int)
    end

    def board_range_valid?(int, board)
        int >= 1 && int <= board.max_positions
    end
    
    def board_size_valid?(input:)
        int = input.to_i
        return int == 3 || int == 4
    end

    def opponent_type_valid?(input:)
        return input == computer || input == human
    end
end