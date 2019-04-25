require_relative './token'
require_relative './board_transformer'

module GameRules
    include Token
    include BoardTransformer

    def win?(board:) 
        horizontal_wins = any_row_a_win?(horizontal(board))

        vertical_wins = any_row_a_win?(vertical(board))

        diagonal_wins = any_row_a_win?(diagonal(board))

        return horizontal_wins || vertical_wins || diagonal_wins
    end

    def tie?(board:)
        return !win?(board: board) && board.full?
    end

    private
    def any_row_a_win?(rows) 
        rows.any? do |row|
            row.all? do |symbol|
                symbol != empty && symbol == row.first
            end
        end
    end
end