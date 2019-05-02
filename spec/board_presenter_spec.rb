require_relative '../lib/board_presenter/board_presenter'
require_relative '../lib/board_presenter/string_board'
require_relative '../lib/player/player_types'
require_relative '../lib/board'

describe 'Board Presenter' do
    # include PlayerTypes

    context 'Initialization' do
        board_presenter = BoardPresenter.new(
            presenter: StringBoard.new()
        )
        it 'sets a presenter' do
            expect(board_presenter.presenter.is_a?(StringBoard)).to eql true
        end
    end

    context 'generate 3x3' do
        new_board = Board.new(size: 3)
        board_presenter = BoardPresenter.new(
            presenter: StringBoard.new()
        )

        p = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

        margin_top = "\n"
        row1 = "0    |1    |2    \n  #{p[0]}  |  #{p[1]}  |  #{p[2]}  \n_____|_____|_____\n"
        row2 = "3    |4    |5    \n  #{p[3]}  |  #{p[4]}  |  #{p[5]}  \n_____|_____|_____\n"
        row3 = "6    |7    |8    \n  #{p[6]}  |  #{p[7]}  |  #{p[8]}  \n     |     |     \n"
        margin_bottom = "\n\n\n"
    
        final_board = margin_top + row1 + row2 + row3 + margin_bottom

        it 'generates version of board' do
            expect(board_presenter.generate(board: new_board)).to eql final_board
        end
    end

    context 'generate 4x4' do
        new_board = Board.new(size: 4)
        updated_board = [
            :X, :empty, :X, :O, 
            :O, :O, :X, :X,
            :X, :X, :X, :X,
            :X, :X, :X, :O
        ]
        new_board.update(position: nil, token:nil, all_positions: updated_board)
        board_presenter = BoardPresenter.new(
            presenter: StringBoard.new()
        )

        p = [
            "X", " ", "X", "O", 
            "O", "O", "X", "X", 
            "X", "X", "X", "X", 
            "X", "X", "X", "O"]

        margin_top = "\n"
        row1 =
        "0    |1    |2    |3    \n  #{p[0]}  |  #{p[1]}  |  #{p[2]}  |  #{p[3]}  \n_____|_____|_____|_____\n"
  
        row2 =
        "4    |5    |6    |7    \n  #{p[4]}  |  #{p[5]}  |  #{p[6]}  |  #{p[7]}  \n_____|_____|_____|_____\n"
  
        row3 =
        "8    |9    |10   |11   \n  #{p[8]}  |  #{p[9]}  |  #{p[10]}  |  #{p[11]}  \n_____|_____|_____|_____\n"
  
        row4 =
        "12   |13   |14   |15   \n  #{p[12]}  |  #{p[13]}  |  #{p[14]}  |  #{p[15]}  \n     |     |     |     \n"
        margin_bottom = "\n\n\n"
    
        final_board = margin_top + row1 + row2 + row3 + row4 + margin_bottom

        it 'generates version of board' do
            expect(board_presenter.generate(board: new_board)).to eql final_board
        end
    end
end
