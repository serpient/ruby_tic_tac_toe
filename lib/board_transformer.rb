module BoardTransformer
    def horizontal_rows(board)
        return board.state.each_slice(board.size).to_a
    end
    
    def vertical_rows(board)
        max_spaces = board.max_spaces
        size = board.size
        (1..size).map do |starting_row|
            generate_row_value(range: starting_row..(max_spaces), num_to_take: size, cut_by_amt: size)
        end
    end

    def diagonal_rows(board)
        top_left_corner = 0
        top_right_corner = board.size - 1
        max_spaces = board.max_spaces
        size = board.size
        [
            generate_row_value(range: top_left_corner..max_spaces, num_to_take: size + 1, cut_by_amt: size),
            generate_row_value(range: top_right_corner..max_spaces, num_to_take: size - 1, cut_by_amt: size)
        ]
    end

    def generate_row_value(range:, num_to_take:, cut_by_amt:)
        row_values = range.select.with_index do |_,position| 
            position % num_to_take == 0
        end
        row_values.take(cut_by_amt)
    end
end