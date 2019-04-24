require_relative '../lib/player'

module Validator
    include PlayerType

    def position_valid?(input:, board:) 
        int = input.to_i
        return board.is_input_valid?(int) && board.is_position_empty?(int)
    end
    
    def board_size_valid?(input:)
        int = input.to_i
        return int == 3 || int == 4
    end

    def opponent_type_valid?(input:)
        return input == computer || input == human
    end
end