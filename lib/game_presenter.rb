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
end

class ConsoleIO
    def get_input(input=nil)
        return gets.chomp
    end

    def output_message(message)
        puts message
    end

    def clear
        print "\e[2J\e[f"
    end
end