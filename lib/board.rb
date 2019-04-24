require_relative './token'

class Board
    include Token
    attr_accessor :size, :positions, :max_positions
    
    def initialize(size:)
        @size = size
        @max_positions = size * size
        @positions = (1..max_positions).map {|num| num = empty }
    end

    def update(position:, token:)
        @positions[position] = token
    end

    def is_full?()
        positions.all? {|position| position != empty }
    end

    def position_is_available?(position)
        return positions[position] == empty
    end

    def empty_positions()
        positions.each_with_index.reduce([]) do |empty_positions, (_position, idx)| 
            empty_positions.push(idx) if is_position_empty?(idx)
            empty_positions
        end
    end

    def is_input_valid?(int)
        int >= 1 && int <= max_positions
    end

    def is_position_empty?(position)
        positions[position] == empty
    end
end