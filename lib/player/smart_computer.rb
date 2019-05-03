require_relative '../Token'
require_relative '../board_transformer'

class SmartComputer
    include Token
    include BoardTransformer
    attr_accessor :token

    def move(board:, presenter:)
        @board = board
        @transformed_boards = BoardTransformer.transform_with_index(board)
        @winning_token_count = board.size 

        take_winning || 
        take_blocking(row_token_count: winning_token_count - 1) || 
        take_center || 
        take_empty_corner || 
        take_row_completing_move(row_token_count: winning_token_count - 2) || 
        take_blocking(row_token_count: winning_token_count - 2) || 
        take_random_position
    end

    private
    attr_accessor :transformed_boards, :board, :winning_token_count

    def take_winning
        find_optimal_move(token_to_find: token, target_token_count: winning_token_count - 1)
    end

    def take_blocking(row_token_count:)
        find_optimal_move(token_to_find: Token::X, target_token_count: row_token_count)
    end

    def take_row_completing_move(row_token_count: )
        find_optimal_move(token_to_find: token, target_token_count: row_token_count) 
    end

    def find_optimal_move(token_to_find: , target_token_count:)
        row = find_row_with_token_count(token_to_find: token_to_find, target_token_count: target_token_count)
        find_empty_position(row) if row
    end

    def find_row_with_token_count(token_to_find:, target_token_count:)
        transformed_boards.find do |transformed_board|
            transformed_board.find do |row|
                row_token_count = count_tokens(row)
    
                has_potential_win = row_token_count[token_to_find] >= target_token_count
                has_empty_position = row_token_count[Token::EMPTY] >= 1
    
                return row if (has_potential_win && has_empty_position)
            end
        end
    end

    def find_empty_position(row)
        row.find { |position| position[0] == Token::EMPTY }[1]
    end

    def count_tokens(row)
        row_token_count = {
            Token::O => 0,
            Token::X => 0,
            Token::EMPTY => 0
        }
        row.each do |position|
            row_token_count[Token::O] += 1 if position.first == Token::O
            row_token_count[Token::EMPTY] += 1 if position.first == Token::EMPTY
            row_token_count[Token::X] += 1 if position.first == Token::X
        end
        row_token_count
    end

    def take_center 
        board.center if board.center && board.position_empty?(board.center)
    end

    def take_empty_corner
        board.corners.find do |corner_position|
            board.position_empty?(corner_position)
        end
    end

    def take_random_position
        board.empty_positions.sample
    end
end