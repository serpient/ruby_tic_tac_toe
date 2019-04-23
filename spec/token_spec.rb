require_relative '../lib/token'

describe 'Token' do
    include Token
    context 'gets tokens' do
        it '- player 1' do
            expect(hero).to eq :hero
        end

        it '- player 2' do
            expect(opponent).to eq :opponent
        end

        it '- empty' do
            expect(empty).to eq :empty
        end
    end
end