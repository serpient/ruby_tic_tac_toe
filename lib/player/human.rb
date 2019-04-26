require_relative '../messages'
require_relative '../validator'

class Human 
    include Messages
    include Validator
    attr_accessor :token

    def move(board:, presenter:)
        presenter.output_message(choose_position(token))
        presenter.get_input
    end

    def get_valid_move(board:, presenter:)
        input = -1 # Starting invalid value
        input = move(board: board, presenter: presenter) while !position_valid?(input: input, board: board)
        input
    end
end