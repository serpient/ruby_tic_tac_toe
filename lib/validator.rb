module Validator
    def position_input_valid?(input:, board:) 
        int = input.to_i
        return board.is_valid_range?(int) && board.is_empty?(int)
    end
end