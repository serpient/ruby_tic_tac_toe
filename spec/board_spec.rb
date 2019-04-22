require_relative '../lib/board'

describe 'Board' do
    context 'Initialization' do
        board = Board.new(
            size: 3
        )

        it 'sets board size' do
            expect(board.size).to eq 3
        end

        it 'creates new board' do
            expect(board.state).to eq [1,2,3,4,5,6,7,8,9]
        end

        it 'sets max spaces' do
            expect(board.max_spaces).to eq 9
        end
    end 
end