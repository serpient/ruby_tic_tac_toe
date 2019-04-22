class GamePresenter
    attr_accessor :presenter

    def initialize(presenter:) 
        @presenter = presenter
    end

    def get_input(input: nil)
        presenter.get_input(input: input)
    end

    def output_message(message:)
        presenter.output_message(message: message)
    end
end

class ConsoleIO
    def get_input(input: nil)
        print "Choose a position: "
        return gets.chomp
    end

    def output_message(message:)
        puts message
    end
end

class TestIO
    def get_input(input: nil)
        return input || "4"
    end

    def output_message(message:)
        message + "\n"
    end
end