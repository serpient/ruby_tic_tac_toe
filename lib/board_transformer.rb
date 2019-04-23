module BoardTransformer
    def horizontal_rows(board)
        return board.positions.each_slice(board.size).to_a
    end
    
    def vertical_rows(board)
        max_positions = board.max_positions
        size = board.size 
        (0..size - 1).map do |starting_row|
            generate_row_value(range: starting_row..(max_positions), num_to_take: size, board: board)
        end
    end

    def diagonal_rows(board)
        top_left_corner = 0
        top_right_corner = board.size - 1
        max_positions = board.max_positions
        size = board.size
        [
            generate_row_value(range: top_left_corner..max_positions, num_to_take: size + 1, board: board),
            generate_row_value(range: top_right_corner..max_positions, num_to_take: size - 1, board: board)
        ]
    end

    def generate_row_value(range:, num_to_take:, board:)
        row_values = range.select.with_index do |_,position| 
            position % num_to_take == 0
        end
        row_values.take(board.size).map do |idx|
            board.positions[idx]
        end
    end
end