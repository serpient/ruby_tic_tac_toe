require_relative '../lib/game'
require_relative '../lib/game'
require_relative '../lib/player/player_types'
require_relative '../lib/game_io/test_io'
require_relative '../lib/game_mode/regular'
require_relative '../lib/game_setting/setting_types'
require_relative '../lib/game_mode/game_mode_types'

describe 'Game' do
    include PlayerType
    include Token
    attr_accessor :game

    context "Initialization" do
        before(:each) do
            @game = Game.new(
                board_size: 3,
                player_2: PlayerType::COMPUTER,
                game_io: TestIO.new,
                board_presenter: StringBoard.new,
                game_mode: "R"
            )
        end

        it "has board_size used to create a Board instance" do
            expect(game.board.size).to eql 3
        end 

        it "set to regular game mode" do
            expect(game.game_mode.is_a?(Regular)).to eql true
        end 

        it 'sets player_1' do
            expect(game.player_1.player.is_a?(Human)).to eq true
        end

        it 'sets player_2' do
            expect(game.player_2.player.is_a?(Computer)).to eq true
        end

        it 'sets current_player' do
            expect(game.current_player.player.is_a?(Human)).to eq true
        end

        it 'sets new board' do
            expect(game.board.positions).to eq [
                Token::EMPTY, Token::EMPTY, Token::EMPTY, 
                Token::EMPTY, Token::EMPTY, Token::EMPTY, 
                Token::EMPTY, Token::EMPTY, Token::EMPTY, 
            ]
        end
    end

    context "play" do
        before(:each) do
            @game = Game.new(
                board_size: 3,
                player_2: PlayerType::COMPUTER,
                game_io: TestIO.new
            )
        end
        
        it 'continues game loop and returns :win or :tie or :save' do
            game.play

            expect(game.status).to eql(:win).or eq(:tie).or eq(:save)
        end

        it 'updates game state and returns :tie if no win and board is full' do
            tie_board = [
                Token::EMPTY, Token::O, Token::X, 
                Token::O, Token::O, Token::X, 
                Token::O, Token::X, Token::O
            ]
            updated_tie_board = [
                Token::X, Token::O, Token::X, 
                Token::O, Token::O, Token::X, 
                Token::O, Token::X, Token::O
            ]
            game.board.update(position: nil, token: nil, all_positions: tie_board)
            game.play

            expect(game.board.positions).to eql updated_tie_board
            expect(game.status).to eql :tie
        end

        it 'updates game state and returns :win if there is a win' do
            win_board = [
                Token::EMPTY, Token::O, Token::O, 
                Token::X, Token::X, Token::O, 
                Token::O, Token::O, Token::X
            ]
            updated_win_board = [Token::X, Token::O, Token::O, Token::X, Token::X, Token::O, Token::O, Token::O, Token::X]
            game.board.update(position: nil, token: nil, all_positions: win_board)
            game.play

            expect(game.board.positions).to eql updated_win_board
            expect(game.status).to eql :win
            expect(game.current_player.token).to eql Token::X
        end
    end

    context 'Lite 3 Mode - updates' do
        include SettingTypes
        include GameModeTypes

        before(:all) do
            @game = Game.new(
                board_size: 3,
                player_2: PlayerType::COMPUTER,
                game_io: TestIO.new,
                board_presenter: StringBoard.new,
                game_mode: "L"
            )
        end

        before(:each) do
            game.switch_players
        end

        it 'Player O - Move 1' do
            game.update(position: 0)
            expect(game.board.positions).to eq [
                Token::O,Token::EMPTY,Token::EMPTY,
                Token::EMPTY,Token::EMPTY,Token::EMPTY,
                Token::EMPTY,Token::EMPTY,Token::EMPTY
            ]
        end

        it 'Player X - Move 1' do
            game.update(position: 1)
            expect(game.board.positions).to eq [
                Token::O,Token::X,Token::EMPTY,
                Token::EMPTY,Token::EMPTY,Token::EMPTY,
                Token::EMPTY,Token::EMPTY,Token::EMPTY
            ]
        end
        

        it 'Player O - Move 2' do
            game.update(position: 2)
            expect(game.board.positions).to eq [
                Token::O,Token::X,Token::O,
                Token::EMPTY,Token::EMPTY,Token::EMPTY,
                Token::EMPTY,Token::EMPTY,Token::EMPTY
            ]
        end

        it 'Player X - Move 2' do
            game.update(position: 3)
            expect(game.board.positions).to eq [
                Token::O,Token::X,Token::O,
                Token::X,Token::EMPTY,Token::EMPTY,
                Token::EMPTY,Token::EMPTY,Token::EMPTY
            ]
        end


        it 'Player O - Move 3' do
            game.update(position: 4)
            expect(game.board.positions).to eq [
                Token::O,Token::X,Token::O,
                Token::X,Token::O,Token::EMPTY,
                Token::EMPTY,Token::EMPTY,Token::EMPTY
            ]
        end

        it 'Player X - Move 3' do
            game.update(position: 5)
            expect(game.board.positions).to eq [
                Token::O,Token::X,Token::O,
                Token::X,Token::O,Token::X,
                Token::EMPTY,Token::EMPTY,Token::EMPTY
            ]
        end

        it 'Player O - Move 4 ; Removes oldest position' do
            game.update(position: 6)
            expect(game.board.positions).to eq [
                Token::EMPTY,Token::X,Token::O,
                Token::X,Token::O,Token::X,
                Token::O,Token::EMPTY,Token::EMPTY
            ]
        end

        it 'Player X - Move 4 ; Removes oldest position' do
            game.update(position: 0)
            expect(game.board.positions).to eq [
                Token::X,Token::EMPTY,Token::O,
                Token::X,Token::O,Token::X,
                Token::O,Token::EMPTY,Token::EMPTY
            ]
        end
    end
end 

