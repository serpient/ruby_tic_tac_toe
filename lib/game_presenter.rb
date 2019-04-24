require_relative '../lib/messages'

class GamePresenter
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

class ConsoleIO
    include Messages
    
    def get_input(input=nil)
        return gets.chomp
    end

    def output_message(message)
        puts message
    end

    def clear
        print "\e[2J\e[f"
    end

    def game_setting_IO(message:)
        clear
        output_message(start_banner)
        output_message(message)
        return get_input
    end
end