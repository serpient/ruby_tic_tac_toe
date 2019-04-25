require_relative '../messages'

class Computer 
    include Messages
    attr_accessor :token

    def move(board:, presenter:)
        position = board.empty_positions.sample
        presenter.output_message(computer_chooses(position, token))
        return position
    end
end