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
end