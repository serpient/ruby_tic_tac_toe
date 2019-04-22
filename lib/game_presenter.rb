class GamePresenter
    attr_accessor :presenter

    def initialize(presenter:) 
        @presenter = presenter
    end

    def get_input()
        presenter.get_input()
    end

    def output_message(message:)
        presenter.output_message(message: message)
    end
end

class ConsoleIO
    def get_input()
        print "Choose a position: "
        return gets.chomp
    end

    def output_message(message:)
        puts message
    end
end

class TestIO
    def get_input()
        return "4"
    end

    def output_message(message:)
        message + "\n"
    end
end