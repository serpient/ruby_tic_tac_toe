require_relative '../lib/player/player_types'
require_relative '../lib/game_setting/game_settings'

describe 'Game Settings' do
    include GameSettings
    # include PlayerTypes

    context 'opponent type valid' do
        it 'returns true if valid' do
            expect(opponent_type[:valid?].(input: "H")).to eql true
        end
        it 'returns false if invalid' do
            expect(opponent_type[:valid?].(input: "3")).to eql false
        end
    end

    context 'board size valid' do
        it 'returns false if invalid' do
            expect(board_size[:valid?].(input: "H")).to eql false
        end
        it 'returns true if valid' do
            expect(board_size[:valid?].(input: "3")).to eql true
        end
    end
end