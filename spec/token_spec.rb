require_relative '../lib/token'

describe 'Token' do
    include Token
    context 'gets tokens' do
        it 'for player 1' do
            expect(player_x).to eq :X
        end

        it 'for player 2' do
            expect(player_o).to eq :O
        end

        it 'for empty' do
            expect(empty).to eq :empty
        end
    end
end