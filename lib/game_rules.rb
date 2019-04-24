require_relative './token'

module GameRules
    include Token
    include BoardTransformer

    def win?(board:) 
        horizontal_wins = any_row_a_win?(horizontal_rows(board))

        vertical_wins = any_row_a_win?(vertical_rows(board))

        diagonal_wins = any_row_a_win?(diagonal_rows(board))

        return [ horizontal_wins, vertical_wins, diagonal_wins ].any?
    end

    def tie?(board:)
        return board.full?
    end

    private
    def any_row_a_win?(rows) 
        rows.any? do |row|
            row.all? do |symbol|
                symbol != empty && symbol == row[0]
            end
        end
    end
end