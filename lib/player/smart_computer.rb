require_relative '../messages'
require_relative '../Token'
require_relative '../board_transformer'

class SmartComputer
    include Token
    include BoardTransformer
    attr_accessor :token

    def move(board:, presenter:)
        @board = board
        @transformed_boards = BoardTransformer.transform_with_idx(board)

        take_winning || 
        take_blocking || 
        take_center || 
        take_empty_corner || 
        take_row_completing_move || 
        take_random_position
    end

    private
    attr_accessor :transformed_boards, :board
    def take_winning
        find_optimal_move(token_to_find: token)
    end

    def take_blocking
        find_optimal_move(token_to_find: Token::X)
    end

    def take_row_completing_move
        find_optimal_move(token_to_find: token, num_of_consecutive_tokens: board.size - 2) 
    end


    def find_optimal_move(token_to_find: , num_of_consecutive_tokens: board.size - 1)
        row = find_row_with_token_count(token_to_find: token_to_find, num_of_consecutive_tokens: num_of_consecutive_tokens)
        return row ? find_empty_position(row) : nil
    end

    def find_row_with_token_count(token_to_find:, num_of_consecutive_tokens: board.size - 1)
        return transformed_boards.find do |transformed_board|
            transformed_board.find do |row|
                token_count = count_tokens(row)
    
                has_potential_win = token_count[token_to_find] >= num_of_consecutive_tokens
                has_empty_position = token_count[Token::EMPTY] >= 1
    
                return row if (has_potential_win && has_empty_position)
            end
        end
    end

    def find_empty_position(row)
        row.find { |position| position[0] == Token::EMPTY }[1]
    end

    def count_tokens(row)
        token_count = {
            Token::O => 0,
            Token::X => 0,
            Token::EMPTY => 0
        }
        row.each do |position|
            token_count[Token::O] += 1 if position.first == Token::O
            token_count[Token::EMPTY] += 1 if position.first == Token::EMPTY
            token_count[Token::X] += 1 if position.first == Token::X
        end
        return token_count
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