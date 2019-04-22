class Board
    attr_accessor :size, :state, :max_spaces

    def initialize(size:)
        @size = size
        @max_spaces = size * size
        @state = (1..max_spaces).to_a
    end
end