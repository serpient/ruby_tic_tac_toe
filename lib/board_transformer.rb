module BoardTransformer
    extend self

    def horizontal(board, with_index: false)
        board_data = with_index ? board.positions_with_index : board.positions
        board_data.each_slice(board.size).to_a
    end
    
    def vertical(board, with_index: false)
        horizontal(board, with_index: with_index).transpose
    end

    def diagonal(board, with_index: false)
        array = horizontal(board, with_index: with_index)
        last_column = board.size - 1
        row_length = 0...board.size
        [
            row_length.map {|index| array[index][index] },
            row_length.map {|index| array[index][last_column - index] }
        ]
    end

    def transform_with_index(board)
        [
            horizontal(board, with_index: true),
            vertical(board, with_index: true),
            diagonal(board, with_index: true)
        ]
    end
end