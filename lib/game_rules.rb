module GameRules
    include BoardTransformer

    def is_game_a_win?(board:) 
        horizontal_wins = is_any_row_a_win?(horizontal_rows(board))

        vertical_wins = is_any_row_a_win?(vertical_rows(board))

        diagonal_wins = is_any_row_a_win?(diagonal_rows(board))

        return [ horizontal_wins, vertical_wins, diagonal_wins ].any?
    end

    def is_game_a_tie?(board:)
        return board.is_full?
    end

    def is_any_row_a_win?(rows) 
        rows.any? do |row|
            row.all? do |symbol|
                symbol != :empty && symbol == row[0]
            end
        end
    end
end