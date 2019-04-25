module BoardTransformer
    def horizontal(board)
        return board.positions.each_slice(board.size).to_a
    end
    
    def vertical(board)
        return horizontal(board).transpose()
    end

    def diagonal(board)
        array = horizontal(board)
        last_idx = board.size - 1
        row_length = 0...board.size
        return [
            row_length.map {|idx| array[idx][idx] },
            row_length.map do |idx| 
                case idx
                when 0
                    array[0][last_idx] 
                when last_idx
                    array[last_idx][0]
                else
                    array[idx][idx]
                end
            end
        ]
    end
end