require_relative '../lib/board_transformer'

describe 'Board Transformer' do
    include BoardTransformer
    context 'Horizontal rows' do
        it 'converts board data to horizontal rows' do
            board = Board.new(size: 2)
            board.update(position: 0, token: 1)
            board.update(position: 1, token: 2)
            board.update(position: 2, token: 3)
            board.update(position: 3, token: 4)
            expect(horizontal_rows(board)).to eql [
                [1, 2],
                [3, 4],
            ]
        end
    end

    context 'Vertical rows' do
        it 'converts 2x2 board data to vertical rows' do
            board = Board.new(size: 2)
            board.update(position: 0, token: 1)
            board.update(position: 1, token: 2)
            board.update(position: 2, token: 3)
            board.update(position: 3, token: 4)
            expect(vertical_rows(board)).to eql [
                [1, 3],
                [2, 4],
            ]
        end

        it 'converts 3x3 board data to vertical rows' do
            board = Board.new(size: 3)
            board.update(position: 0, token: 1)
            board.update(position: 1, token: 2)
            board.update(position: 2, token: 3)
            board.update(position: 3, token: 4)
            board.update(position: 4, token: 5)
            board.update(position: 5, token: 6)
            board.update(position: 6, token: 7)
            board.update(position: 7, token: 8)
            board.update(position: 8, token: 9)
            expect(vertical_rows(board)).to eql [
                [1, 4, 7],
                [2, 5, 8],
                [3, 6, 9],
            ]
        end
    end

    context 'Diagonal rows' do
        it 'converts 2x2 board data to diagonal rows' do
            board = Board.new(size: 2)
            board.update(position: 0, token: 1)
            board.update(position: 1, token: 2)
            board.update(position: 2, token: 3)
            board.update(position: 3, token: 4)
            expect(diagonal_rows(board)).to eql [
                [0, 3],
                [1, 2],
            ]
        end

        it 'converts board data to vertical rows' do
            board = Board.new(size: 3)
            board.update(position: 0, token: 1)
            board.update(position: 1, token: 2)
            board.update(position: 2, token: 3)
            board.update(position: 3, token: 4)
            board.update(position: 4, token: 5)
            board.update(position: 5, token: 6)
            board.update(position: 6, token: 7)
            board.update(position: 7, token: 8)
            board.update(position: 8, token: 9)
            expect(vertical_rows(board)).to eql [
                [1, 4, 7],
                [2, 5, 8],
                [3, 6, 9],
            ]
        end
    end
end