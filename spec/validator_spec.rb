require_relative '../lib/validator'
require_relative '../lib/board'


describe 'Validator' do
    include Validator
    context 'position_input_valid?' do
        board = Board.new(size: 2)
        board.update(position: 0, token: :hero)
        board.update(position: 2, token: :hero)
        board.update(position: 3, token: :hero)
        it 'returns false if input is unusable' do
            expect(position_input_valid?(input: "2", board: board)).to eq false
        end

        it 'returns true if input is usable' do
            expect(position_input_valid?(input: "1", board: board)).to eq true
        end

        it 'returns false if input is out of range' do
            expect(position_input_valid?(input: "5", board: board)).to eq false
        end
    end

    context 'board_size_valid?' do
        it 'returns false if input is not 3 or 4' do
            expect(board_size_valid?(input: "2")).to eq false
        end

        it 'returns true if input is 3 or 4' do
            expect(board_size_valid?(input: "4")).to eq true
        end
    end

    context 'opponent_type_valid?' do
        it 'returns false if input is NOT (H) or (C)' do
            expect(opponent_type_valid?(input: "A")).to eq false
        end

        it 'returns true if input is (H) or (C)' do
            expect(opponent_type_valid?(input: "H")).to eq true
        end
    end
end