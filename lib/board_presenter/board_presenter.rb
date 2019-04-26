class BoardPresenter
    attr_accessor :presenter, :board

    def initialize(presenter:, board:)
        @presenter = presenter
        @board = board
        presenter.board = board
    end

    def generate
        presenter.generate
    end

    def output
        presenter.output
    end
end