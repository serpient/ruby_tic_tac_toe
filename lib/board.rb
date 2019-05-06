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

    def empty_positions
        positions.each_with_index.reduce([]) do |empty_positions, (_position, index)| 
            empty_positions.push(index) if position_empty?(index)
            empty_positions
        end
    end

    def position_empty?(position)
        positions[position] == Token::EMPTY
    end

    PositionWithIndex = Struct.new(:value, :index)

    def positions_with_index
        positions.map.with_index { |value, index| PositionWithIndex.new(value, index) }
    end

    def center
        4 if size == 3
    end

    def corners
        corners = [0]
        corners[1] = size - 1
        corners[2] = corners[1] * size
        corners[3] = corners[2] + corners[1]
        corners
    end
end