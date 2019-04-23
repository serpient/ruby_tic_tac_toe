module Validator
    def position_input_valid?(input:, board:) 
        int = input.to_i
        return board.is_input_valid?(int) && board.is_position_empty?(int)
    end
end