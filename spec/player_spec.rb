require_relative '../lib/player/player'
require_relative '../lib/player/human'
require_relative '../lib/player/computer'
require_relative '../lib/player/smart_computer'
require_relative '../lib/player/player_types'
require_relative '../lib/token'
require_relative '../lib/game_io/game_io'
require_relative '../lib/game_io/test_io'

describe 'Player' do
    include Token

    context 'Initialization' do
        it 'sets player' do
            human_player = Player.new(
                player: Human.new,
                token: Token::X,
            )
            expect(human_player.player.is_a?(Human)).to eq true
        end

        it 'sets smart computer player' do
            computer_player = Player.new(
                player: SmartComputer.new,
                token: Token::O,
            )
            expect(computer_player.player.is_a?(SmartComputer)).to eq true
        end
    end

    context 'move' do
        it 'gets valid human input' do
            human_player = Player.new(
                player: Human.new,
                token: Token::X,
            )
            board = Board.new(size: 3)
            presenter = GameIO.new(presenter: TestIO.new)
            expect(human_player.move(board: board, presenter: presenter)).to eq "4"
        end

        it 'gets valid computer input' do
            computer_player = Player.new(
                player: Computer.new,
                token: Token::X,
            )
            board = Board.new(size: 2)
            presenter = GameIO.new(presenter: TestIO.new)
            board.update(position: 0, token: Token::X)
            board.update(position: 2, token: Token::X)
            board.update(position: 3, token: Token::X)

            expect(computer_player.move(board: board, presenter: presenter)).to eq 1
        end
    end
end

describe 'Smart Computer' do

    attr_accessor :computer_player, :board, :presenter

    before(:all) do
        @computer_player = Player.new(
            player: SmartComputer.new,
            token: Token::O,
        )
        @board = Board.new(size: 3)
        @presenter = GameIO.new(presenter: TestIO.new)
    end

    context 'winning move - 3x3' do
        it 'takes diagonal winning move if possible' do
            smart_computer_board = [
                Token::X, Token::EMPTY, Token::O, 
                Token::EMPTY, Token::EMPTY, Token::X, 
                Token::O, Token::EMPTY, Token::EMPTY
            ]
            board.update(position: nil, token: nil, all_positions: smart_computer_board)
            expect(computer_player.move(board: board, presenter: presenter)).to eq 4
        end

        it 'takes horizontal winning move if possible' do
            smart_computer_board = [
                Token::O, Token::EMPTY, Token::O, 
                Token::EMPTY, Token::EMPTY, Token::EMPTY, 
                Token::EMPTY, Token::EMPTY, Token::EMPTY
            ]
            board.update(position: nil, token: nil, all_positions: smart_computer_board)
            expect(computer_player.move(board: board, presenter: presenter)).to eq 1
        end


        it 'takes vertical winning move if possible' do
            smart_computer_board = [
                Token::EMPTY, Token::EMPTY, Token::O, 
                Token::EMPTY, Token::EMPTY, Token::O, 
                Token::EMPTY, Token::EMPTY, Token::EMPTY
            ]
            board.update(position: nil, token: nil, all_positions: smart_computer_board)
            expect(computer_player.move(board: board, presenter: presenter)).to eq 8
        end
    end

    context 'blocking move' do
        it 'takes vertical blocking move if possible' do
            smart_computer_board = [
                Token::EMPTY, Token::X, Token::EMPTY, 
                Token::EMPTY, Token::EMPTY, Token::EMPTY, 
                Token::EMPTY, Token::X, Token::EMPTY
            ]
            board.update(position: nil, token: nil, all_positions: smart_computer_board)
            expect(computer_player.move(board: board, presenter: presenter)).to eq 4
        end

        it 'takes horizontal blocking move if possible' do
            smart_computer_board = [
                Token::EMPTY, Token::EMPTY, Token::EMPTY, 
                Token::EMPTY, Token::EMPTY, Token::EMPTY, 
                Token::EMPTY, Token::X, Token::X
            ]
            board.update(position: nil, token: nil, all_positions: smart_computer_board)
            expect(computer_player.move(board: board, presenter: presenter)).to eq 6
        end

        it 'takes diagonal blocking move if possible' do
            smart_computer_board = [
                Token::EMPTY, Token::EMPTY, Token::EMPTY, 
                Token::EMPTY, Token::X, Token::EMPTY, 
                Token::X, Token::EMPTY, Token::EMPTY
            ]
            board.update(position: nil, token: nil, all_positions: smart_computer_board)
            expect(computer_player.move(board: board, presenter: presenter)).to eq 2
        end
    end

    context 'optimal move' do
        it 'takes center move in a 3x3 board' do
            smart_computer_board = [
                Token::EMPTY, Token::EMPTY, Token::EMPTY, 
                Token::EMPTY, Token::EMPTY, Token::EMPTY, 
                Token::EMPTY, Token::EMPTY, Token::EMPTY
            ]
            board.update(position: nil, token: nil, all_positions: smart_computer_board)
            expect(computer_player.move(board: board, presenter: presenter)).to eq 4
        end

        it 'takes corner move if center is not available board' do
            smart_computer_board = [
                Token::EMPTY, Token::EMPTY, Token::EMPTY, 
                Token::EMPTY, Token::X, Token::EMPTY, 
                Token::EMPTY, Token::EMPTY, Token::EMPTY
            ]
            board.update(position: nil, token: nil, all_positions: smart_computer_board)
            expect(computer_player.move(board: board, presenter: presenter)).to eq(0).or eq(2).or eq(6).or eq(8)
        end

        it 'takes random move if center or corner is not available' do
            smart_computer_board = [
                Token::X, Token::EMPTY, Token::X, 
                Token::EMPTY, Token::X, Token::EMPTY, 
                Token::X, Token::EMPTY, Token::X
            ]
            board.update(position: nil, token: nil, all_positions: smart_computer_board)
            expect(computer_player.move(board: board, presenter: presenter)).to eq(1).or eq(3).or eq(5).or eq(7)
        end
    end

    context 'all strategies' do
        it 'takes the best move' do
            smart_computer_board = [
                Token::X, Token::EMPTY, Token::EMPTY, 
                Token::EMPTY, Token::O, Token::EMPTY, 
                Token::X, Token::EMPTY, Token::EMPTY
            ]
            board.update(position: nil, token: nil, all_positions: smart_computer_board)
            expect(computer_player.move(board: board, presenter: presenter)).to eq 3
        end
    end

    context '4x4' do

        before(:all) do
            @board = Board.new(size: 4)
        end

        it 'takes winning move if possible' do
            smart_computer_board = [
                Token::EMPTY, Token::EMPTY, Token::EMPTY, Token::O,
                Token::EMPTY, Token::EMPTY, Token::EMPTY, Token::EMPTY,
                Token::EMPTY, Token::O, Token::EMPTY, Token::EMPTY,
                Token::O, Token::EMPTY, Token::EMPTY, Token::EMPTY,
            ]
            board.update(position: nil, token: nil, all_positions: smart_computer_board)
            expect(computer_player.move(board: board, presenter: presenter)).to eq 6
        end

        it 'takes blocking move if possible' do
            smart_computer_board = [
                Token::EMPTY, Token::EMPTY, Token::EMPTY, Token::EMPTY,
                Token::X, Token::EMPTY, Token::X, Token::X,
                Token::EMPTY, Token::EMPTY, Token::EMPTY, Token::EMPTY,
                Token::EMPTY, Token::EMPTY, Token::EMPTY, Token::EMPTY,
            ]
            board.update(position: nil, token: nil, all_positions: smart_computer_board)
            expect(computer_player.move(board: board, presenter: presenter)).to eq 5
        end

        it 'takes corner if possible' do
            smart_computer_board = [
                Token::EMPTY, Token::EMPTY, Token::EMPTY, Token::EMPTY,
                Token::EMPTY, Token::EMPTY, Token::EMPTY, Token::X,
                Token::EMPTY, Token::EMPTY, Token::EMPTY, Token::EMPTY,
                Token::EMPTY, Token::EMPTY, Token::EMPTY, Token::EMPTY,
            ]
            board.update(position: nil, token: nil, all_positions: smart_computer_board)
            expect(computer_player.move(board: board, presenter: presenter)).to eq(0).or eq(3).or eq(12).or eq(15)
        end


        it 'takes next best move to win if center or corner is not available' do
            smart_computer_board = [
                Token::O, Token::EMPTY, Token::EMPTY, Token::O,
                Token::EMPTY, Token::EMPTY, Token::EMPTY, Token::EMPTY,
                Token::EMPTY, Token::EMPTY, Token::EMPTY, Token::EMPTY,
                Token::X, Token::EMPTY, Token::EMPTY, Token::X,
            ]
            board.update(position: nil, token: nil, all_positions: smart_computer_board)
            expect(computer_player.move(board: board, presenter: presenter)).to eq(1).or eq(2)
        end
    end
end

