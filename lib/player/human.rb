require_relative '../messages'
require_relative '../validator'

class Human 
    include Messages
    include Validator
    attr_accessor :token

    def get_valid_move(board:, presenter:)
        input = -1 # Starting invalid value
        # write this in a way that doesnt need a starting input. maybe default?
        input = move(board: board, presenter: presenter) while !position_valid?(input: input, board: board)
        input
    end

    private
    def move(board:, presenter:)
        presenter.output_message(choose_position(token))
        presenter.get_input
    end
end

# functional core and imperative shell?
# slightly leaky, in that the functional is mixed with IO

# instead of get valid move, game should decide on validation, not the player of human
