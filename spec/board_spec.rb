require_relative '../lib/board'
require_relative '../lib/token'

describe 'Board' do
    include Token
    context 'Initialization' do
        board = Board.new(
            size: 3
        )

        it 'sets board size' do
            expect(board.size).to eq 3
        end

        it 'creates new board' do
            expect(board.positions).to eq [empty,empty,empty,empty,empty,empty,empty,empty,empty]
        end

        it 'sets max spaces' do
            expect(board.max_positions).to eq 9
        end
    end  

    context 'Update' do
        it 'updates a position in board positions' do
            board = Board.new(
                size: 2
            )
            board.update(
                position: 0, 
                token: hero
            )
            expect(board.positions).to eq [hero, empty, empty, empty]
        end
    end

    context 'Position_Is_Available' do
        it 'returns true if position is empty' do
            board = Board.new(
                size: 2
            )
            expect(board.position_is_available?(0)).to eq true
        end
    end

    context 'Is_Full' do
        it 'returns false when board is not full' do
            board = Board.new(
                size: 2
            )
            expect(board.is_full?()).to eq false
        end

        it 'returns true when board is full' do
            board = Board.new(
                size: 2
            )

            board.update(position: 0, token: hero)
            board.update(position: 1, token: hero)
            board.update(position: 2, token: hero)
            board.update(position: 3, token: hero)

            expect(board.is_full?()).to eq true
        end
    end

    context 'Empty_Positions' do
        it 'returns a list of empty position indexes' do
            board = Board.new(size: 2)

            expect(board.empty_positions()).to eq [0,1,2,3]
        end
    end
end