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
end