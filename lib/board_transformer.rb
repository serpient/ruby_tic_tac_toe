module BoardTransformer
    extend self

    def horizontal(board, with_idx: false)
        board_data = with_idx ? board.positions_with_idx : board.positions
        board_data.each_slice(board.size).to_a
    end
    
    def vertical(board, with_idx: false)
        horizontal(board, with_idx: with_idx).transpose
    end

    def diagonal(board, with_idx: false)
        array = horizontal(board, with_idx: with_idx)
        last_idx = board.size - 1
        row_length = 0...board.size
        [
            row_length.map {|idx| array[idx][idx] },
            row_length.map do |idx| 
                case idx
                when 0
                    array[0][last_idx] 
                when last_idx
                    array[last_idx][0]
                else
                    array[idx][last_idx - idx]
                end
            end
        ]
    end
end