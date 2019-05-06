class Computer 
    attr_accessor :token

    def move(board:, presenter:)
        board.empty_positions.sample
    end
end