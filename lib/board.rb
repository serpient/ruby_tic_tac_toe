require_relative './token'

class Board
    include Token
    attr_accessor :size, :positions, :max_positions
    
    def initialize(size:)
        @size = size
        @max_positions = size * size
        @positions = (1..max_positions).map {|num| num = Token::EMPTY }
    end

    def update(position:, token:, all_positions: nil)
        all_positions ? @positions = all_positions : @positions[position] = token
    end

    def full?
        positions.all? {|position| position != Token::EMPTY }
    end

    def xf?(position)
        positions[position] == Token::EMPTY
    end

    def empty_positions
        positions.each_with_index.reduce([]) do |empty_positions, (_position, idx)| 
            empty_positions.push(idx) if position_empty?(idx)
            empty_positions
        end
    end

    def position_empty?(position)
        positions[position] == Token::EMPTY
    end

    def positions_with_idx
        positions.map.with_index { |val, idx| [val, idx] }
    end

    def center
        size == 3 ? 4 : nil
    end

    def corners
        if size == 3
            return [0, 2, 6, 8]
        else
            return [0, 3, 12, 15]
        end
    end
end