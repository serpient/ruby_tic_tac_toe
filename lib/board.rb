require_relative './token'

class Board
    include Token
    attr_accessor :size, :positions, :max_positions
    
    def initialize(size:)
        @size = size
        @max_positions = size * size
        @positions = (1..max_positions).map {|num| num = empty }
    end

    def update(position:, token:, all_positions: nil)
        all_positions ? @positions = all_positions : @positions[position] = token
    end

    def full?
        positions.all? {|position| position != empty }
    end

    def position_available?(position)
        positions[position] == empty
    end

    def empty_positions
        positions.each_with_index.reduce([]) do |empty_positions, (_position, idx)| 
            empty_positions.push(idx) if position_empty?(idx)
            empty_positions
        end
    end

    def position_empty?(position)
        positions[position] == empty
    end
end