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

        takes_winning_move || 
        takes_blocking_move || 
        takes_next_optimal_move
    end

    private
    attr_accessor :transformed_boards, :board
    def takes_winning_move
        find_finishing_move(token_to_find: token)
    end

    def takes_blocking_move
        find_finishing_move(token_to_find: Token::X)
    end

    def takes_next_optimal_move
        choose_center || 
        choose_empty_corner || 
        find_finishing_move(token_to_find: token, num_of_moves_before_win: 2) || 
        board.empty_positions.sample
    end

    def find_finishing_move(token_to_find:, num_of_moves_before_win: 1)
        valid_move = nil
        transformed_boards.find do |transformed_board|
            valid_move = find_winning_position(
                transformed_board: transformed_board, 
                num_of_moves_before_win: num_of_moves_before_win, 
                token_to_find: token_to_find
            )
        end
        return valid_move
    end

    def find_winning_position(transformed_board:, num_of_moves_before_win:, token_to_find:) 
        transformed_board.find.reduce(nil) do |move, row|
            token_count = count_tokens(row)

            close_to_win = token_count[token_to_find] >= board.size - num_of_moves_before_win
            has_empty_position = token_count[Token::EMPTY] >= 1

            if (close_to_win && has_empty_position)
                move = find_empty_position(row)
            end

            move
        end
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

    def find_empty_position(row)
        row.find { |position| position[0] == Token::EMPTY }[1]
    end

    def choose_center 
        board.center if board.center && board.position_empty?(board.center)
    end

    def choose_empty_corner
        board.corners.find do |corner_position|
            board.position_empty?(corner_position)
        end
    end
end