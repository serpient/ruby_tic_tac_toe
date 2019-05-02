require_relative '../messages'
require_relative '../Token'
require_relative '../board_transformer'

class SmartComputer
    include Messages
    include Token
    include BoardTransformer
    attr_accessor :token

    def move(board:, presenter:)
        @board = board
        @all_transformed_boards = transform(board)

        takes_winning_move || takes_blocking_move || takes_next_optimal_move
    end

    private
    attr_accessor :all_transformed_boards, :board
    def transform(board)
        [
            horizontal(board, with_idx: true),
            vertical(board, with_idx: true),
            diagonal(board, with_idx: true)
        ]
    end

    def takes_winning_move
        find_finishing_move(token_to_find: Token::O)
    end

    def takes_blocking_move
        find_finishing_move(token_to_find: Token::X)
    end

    def takes_next_optimal_move
        return board.center if board.center && board.position_empty?(board.center)
        corner = board.corners.find do |corner_position|
            board.position_empty?(corner_position)
        end
        return corner ? corner : board.empty_positions.sample
    end

    def find_finishing_move(token_to_find:)
        valid_move = nil
        all_transformed_boards.each do |rows|
            position = find_almost_winning_position(rows: rows, board: board, token_to_find: token_to_find)
            valid_move = position if position
        end
        return valid_move
    end

    def find_almost_winning_position(rows:, board:, token_to_find:) 
        move = nil
        rows.find do |row|
            counter_of = {
                Token::O => 0,
                Token::X => 0,
                Token::EMPTY => 0
            }
            row.each do |position|
                counter_of[Token::O] += 1 if position.first == Token::O
                counter_of[Token::EMPTY] += 1 if position.first == Token::EMPTY
                counter_of[Token::X] += 1 if position.first == Token::X
            end
            if (counter_of[token_to_find] == (board.size - 1) && counter_of[Token::EMPTY] >= 1)
                position = row.find { |position| position[0] != Token::O && position[0] != Token::X }
                move = position[1]
            end
        end
        move
    end
end