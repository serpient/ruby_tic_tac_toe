require_relative './player/player_types'

module Validator
    include PlayerType

    def position_valid?(input:, board:) 
        int = input.to_i
        board_range_valid?(int,board) && board.position_empty?(int)
    end

    def board_range_valid?(int, board)
        int >= 0 && int < board.max_positions
    end
    
    def board_size_valid?(input:)
        int = input.to_i
        int == 3 || int == 4
    end

    def opponent_type_valid?(input:)
        input == PlayerType::COMPUTER || input == PlayerType::HUMAN
    end
end