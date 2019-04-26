class BoardPresenter
    attr_accessor :presenter

    def initialize(presenter:)
        @presenter = presenter
    end

    def generate(board:)
        presenter.generate(board: board)
    end

    def output
        presenter.output
    end
end