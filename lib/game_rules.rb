require_relative './token'
require_relative './board_transformer'

module GameRules
    extend self

    include Token
    include BoardTransformer

    def win?(board:) 
        horizontal_wins = any_row_a_win?(BoardTransformer.horizontal(board))
        vertical_wins = any_row_a_win?(BoardTransformer.vertical(board))
        diagonal_wins = any_row_a_win?(BoardTransformer.diagonal(board))
        horizontal_wins || vertical_wins || diagonal_wins
    end

    def tie?(board:)
        !win?(board: board) && board.full?
    end

    private
    def any_row_a_win?(rows) 
        rows.any? do |row|
            row.all? do |symbol|
                symbol != Token::EMPTY && symbol == row.first
            end
        end
    end
end