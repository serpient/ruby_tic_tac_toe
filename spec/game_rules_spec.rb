require_relative '../lib/game_rules'
require_relative '../lib/token'

describe 'Game Rules' do
    attr_accessor :board
    include GameRules
    include Token

    context 'win? 4x4' do
        before(:each) do
            @board = Board.new(size: 4)
        end
        it 'returns false on initial board' do
            expect(win?(board: board)).to eq false
        end
        it 'returns false if there are no matching symbols' do
            board.update(position: 0, token: Token::X)
            expect(win?(board: board)).to eq false
        end
        it 'returns true if there are matching horizontal symbols' do
            board.update(position: 0, token: Token::X)
            board.update(position: 1, token: Token::X)
            board.update(position: 2, token: Token::X)
            board.update(position: 3, token: Token::X)
            expect(win?(board: board)).to eq true
        end

        it 'returns true if there are matching vertical symbols' do
            board.update(position: 0, token: Token::X)
            board.update(position: 4, token: Token::X)
            board.update(position: 8, token: Token::X)
            board.update(position: 12, token: Token::X)
            expect(win?(board: board)).to eq true
        end

        it 'returns true if there are matching diagonal symbols' do
            board.update(position: 0, token: Token::X)
            board.update(position: 5, token: Token::X)
            board.update(position: 10, token: Token::X)
            board.update(position: 15, token: Token::X)
            expect(win?(board: board)).to eq true
        end
    end

    context 'win? 3x3' do
        before(:each) do
            @board = Board.new(size: 3)
        end
        it 'returns false if there are no matching symbols' do
            board.update(position: 0, token: Token::X)
            expect(win?(board: board)).to eq false
        end
        it 'returns true if there are matching horizontal symbols' do
            board.update(position: 0, token: Token::X)
            board.update(position: 1, token: Token::X)
            board.update(position: 2, token: Token::X)
            expect(win?(board: board)).to eq true
        end
        it 'returns false if there are no matching horizontal symbols' do
            board.update(position: 0, token: Token::X)
            board.update(position: 5, token: Token::X)
            board.update(position: 2, token: Token::X)
            expect(win?(board: board)).to eq false
        end
        it 'returns true if there are matching vertical symbols' do
            board.update(position: 0, token: Token::X)
            board.update(position: 3, token: Token::X)
            board.update(position: 6, token: Token::X)
            expect(win?(board: board)).to eq true
        end
        it 'returns true if there are matching diagonal symbols' do
            board.update(position: 0, token: Token::X)
            board.update(position: 4, token: Token::X)
            board.update(position: 8, token: Token::X)
            expect(win?(board: board)).to eq true
        end

        it 'returns true if there are no matching diagonal symbols' do
            board.update(position: 0, token: Token::X)
            board.update(position: 2, token: Token::X)
            board.update(position: 8, token: Token::X)
            expect(win?(board: board)).to eq false
        end
    end

    context 'game is tie checker' do
        before(:each) do
            @board = Board.new(size: 2)
        end
        it 'returns false if game is not a tie' do
            expect(tie?(board: board)).to eq false
        end
        it 'returns true if game is tie / board is full' do
            tie_board = [1,2,3,4]
            board.update(position: nil, token: nil, all_positions: tie_board)
            expect(tie?(board: board)).to eq true
        end
    end
end