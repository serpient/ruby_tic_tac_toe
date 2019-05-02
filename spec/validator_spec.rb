require_relative '../lib/validator'
require_relative '../lib/board'
require_relative '../lib/player/player_types'
require_relative '../lib/token'

describe 'Validator' do
    include Validator
    include PlayerType
    include Token

    attr_accessor :board

    before(:each) do
        @board = Board.new(size: 2)
        board.update(position: 0, token: player_x)
        board.update(position: 2, token: player_x)
        board.update(position: 3, token: player_x)
    end

    context 'position_valid?' do
        it 'returns false if input is unusable' do
            expect(position_valid?(input: "2", board: board)).to eq false
        end

        it 'returns true if input is usable' do
            expect(position_valid?(input: "1", board: board)).to eq true
        end

        it 'returns false if input is out of range' do
            expect(position_valid?(input: "4", board: board)).to eq false
        end

        it 'returns false if input is out of range' do
            expect(position_valid?(input: "5", board: board)).to eq false
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
            expect(opponent_type_valid?(input: computer)).to eq true
        end
    end

    context 'board_range_valid?' do
        board = Board.new(size: 2)
        it 'returns false if input is above 4' do
            expect(board_range_valid?(4, board)).to eq false
        end

        it 'returns true if input is between 1 and 4' do
            expect(board_range_valid?(3, board)).to eq true
        end

        it 'returns false if input is below 0' do
            expect(board_range_valid?(-1, board)).to eq false
        end
    end
end