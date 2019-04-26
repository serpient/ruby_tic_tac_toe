require_relative '../messages'

class GameIO
    attr_accessor :presenter

    def initialize(presenter:) 
        @presenter = presenter
    end

    def get_input(input=nil)
        presenter.get_input(input)
    end

    def output_message(message)
        presenter.output_message(message)
    end

    def clear
        presenter.clear
    end

    def game_setting_IO(message:)
        presenter.game_setting_IO(message: message)
    end
end
