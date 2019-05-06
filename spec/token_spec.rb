require_relative '../lib/token'

describe 'Token' do
    include Token
    context 'gets tokens' do
        it 'for player 1' do
            expect(Token::X).to eq :X
        end

        it 'for player 2' do
            expect(Token::O).to eq :O
        end

        it 'for empty' do
            expect(Token::EMPTY).to eq :empty
        end
    end
end