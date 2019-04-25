require_relative '../lib/board_transformer'

describe 'Board Transformer' do
    include BoardTransformer
    context 'Horizontal rows' do
        it 'converts board data to horizontal rows' do
            board = Board.new(size: 2)
            new_2x2_board_positions = [1,2,3,4]
            board.update(position: nil, token: nil, all_positions: new_2x2_board_positions)
            expect(horizontal(board)).to eql [
                [1, 2],
                [3, 4],
            ]
        end

        it 'converts 3x3 board data to vertical rows' do
            board = Board.new(size: 3)
            new_3x3_board_positions = [1,2,3,4,5,6,7,8,9]
            board.update(position: nil, token: nil, all_positions: new_3x3_board_positions)
            expect(horizontal(board)).to eql [
                [1, 2, 3],
                [4, 5, 6],
                [7, 8, 9],
            ]
        end
    end

    context 'Vertical rows' do
        it 'converts 2x2 board data to vertical rows' do
            board = Board.new(size: 2)
            new_2x2_board_positions = [1,2,3,4]
            board.update(position: nil, token: nil, all_positions: new_2x2_board_positions)
            expect(vertical(board)).to eql [
                [1, 3],
                [2, 4],
            ]
        end

        it 'converts 3x3 board data to vertical rows' do
            board = Board.new(size: 3)
            new_3x3_board_positions = [1,2,3,4,5,6,7,8,9]
            board.update(position: nil, token: nil, all_positions: new_3x3_board_positions)
            expect(vertical(board)).to eql [
                [1, 4, 7],
                [2, 5, 8],
                [3, 6, 9],
            ]
        end
    end

    context 'Diagonal rows' do
        it 'converts 2x2 board data to diagonal rows' do
            board = Board.new(size: 2)
            new_2x2_board_positions = [1,2,3,4]
            board.update(position: nil, token: nil, all_positions: new_2x2_board_positions)
            expect(diagonal(board)).to eql [
                [1, 4],
                [2, 3],
            ]
        end

        it 'converts 3x3 data to diagonal rows' do
            board = Board.new(size: 3)
            new_3x3_board_positions = [1,2,3,4,5,6,7,8,9]
            board.update(position: nil, token: nil, all_positions: new_3x3_board_positions)
            expect(diagonal(board)).to eql [
                [1, 5, 9],
                [3, 5, 7],
            ]
        end
    end
end