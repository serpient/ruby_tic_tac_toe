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

    def clear()
        presenter.clear()
    end
end

class ConsoleIO
    def get_input(input: nil)
        return gets.chomp
    end

    def output_message(message:)
        puts message
    end

    def clear()
        print "\e[2J\e[f"
    end
end

class TestIO
    attr_accessor :count

    def initialize()
        @count = 0
    end

    def update_count()
        @count += 1
    end

    def get_input(input: nil)
        return input if input != nil

        value = case count 
        when 0
            "4"
        when 1
            "H"
        when 2
            "0"
        else
            "1"
        end
        update_count()
        return value
    end

    def output_message(message:)
        message + "\n"
    end

    def clear()
        return
    end
end