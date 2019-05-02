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
            expect(board.positions).to eq [Token::EMPTY,Token::EMPTY,Token::EMPTY,Token::EMPTY,Token::EMPTY,Token::EMPTY,Token::EMPTY,Token::EMPTY,Token::EMPTY]
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
                token: Token::X
            )
            expect(board.positions).to eq [Token::X, Token::EMPTY, Token::EMPTY, Token::EMPTY]
        end
    end

    context 'position_available' do
        it 'returns true if position is Token::EMPTY' do
            board = Board.new(
                size: 2
            )
            expect(board.position_empty?(0)).to eq true
        end
    end

    context 'full' do
        it 'returns false when board is not full' do
            board = Board.new(
                size: 2
            )
            expect(board.full?).to eq false
        end

        it 'returns true when board is full' do
            board = Board.new(
                size: 2
            )

            new_2x2_board_positions = [1,2,3,4]
            board.update(position: nil, token: nil, all_positions: new_2x2_board_positions)

            expect(board.full?).to eq true
        end

        it 'returns true when board is full' do
            board = Board.new(
                size: 3
            )

            tie_board = [Token::X, Token::X, Token::X,Token::X,Token::X,Token::X,Token::X,Token::X,Token::X,]
            board.update(position: nil, token: nil, all_positions: tie_board)

            expect(board.full?).to eq true
        end
    end

    context 'Token::EMPTY_Positions' do
        it 'returns a list of Token::EMPTY position indexes' do
            board = Board.new(size: 2)

            expect(board.empty_positions).to eq [0,1,2,3]
        end
    end
end