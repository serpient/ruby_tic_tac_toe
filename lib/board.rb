class Board
    attr_accessor :size, :state, :max_spaces

    def initialize(size:)
        @size = size
        @max_spaces = size * size
        @state = (1..max_spaces).map {|num| num = :empty }
    end

    def update(position:, token:)
        state[position] = token
        return state
    end

    def is_full?()
        state.all? {|position| position != :empty }
    end

    def position_is_available?(position)
        return state[position] == :empty
    end

    def empty_positions()
        state.each_with_index.reduce([]) do |empty_positions, (position, idx)| 
            position == :empty && empty_positions.push(idx)
            empty_positions
        end
    end

    def is_valid_range?(int)
        int >= 1 && int <= max_spaces
    end

    def is_empty?(int)
        state[int] == :empty
    end
end