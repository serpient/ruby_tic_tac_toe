require_relative '../messages'

class Human 
    include Messages
    attr_accessor :token

    def move(board:, presenter:)
        presenter.output_message(choose_position(token))
        presenter.get_input
    end
end