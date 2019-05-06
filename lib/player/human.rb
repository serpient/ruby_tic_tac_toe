require_relative '../messages'

class Human 
    include Messages
    attr_accessor :token

    def move(board:, presenter:)
        presenter.output_message(Messages.choose_position(token))
        presenter.get_input
    end
end