class GameIO
    attr_accessor :presenter

    def initialize(presenter:) 
        @presenter = presenter
    end

    def input(input=nil)
        presenter.input(input)
    end

    def output_message(message)
        presenter.output_message(message)
    end

    def clear
        presenter.clear
    end
end
