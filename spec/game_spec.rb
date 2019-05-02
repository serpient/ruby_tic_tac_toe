require_relative '../lib/game'
require_relative '../lib/game_state'
require_relative '../lib/player/player_types'
require_relative '../lib/game_io/test_io'

describe 'Game' do
    include PlayerType
    include Token
    attr_accessor :game

    context "Initialization" do
        before(:each) do
            @game = Game.new(
                board_size: 3,
                player_2: PlayerType::HUMAN,
                game_io: TestIO.new(),
                board_presenter: StringBoard.new()
            )
        end

        it "has board_size used to create a Board instance" do
            expect(game.game_state.board.size).to eql 3
        end 

        it "has game state generated" do
            expect(game.game_state.is_a?(GameState)).to eql true
        end 

        it "has player 2 generated" do
            expect(game.game_state.player_2.player.is_a?(Human)).to eql true
        end 
    end

    context "play" do
        before(:each) do
            @game = Game.new(
                board_size: 3,
                player_2: PlayerType::COMPUTER,
                game_io: TestIO.new()
            )
        end
        
        it 'continues game loop and returns :win or :tie' do
            game.play()

            expect(game.status).to eql (:win or :tie)
            expect(game.game_state.board.positions.include?(Token::X)).to eql true
        end

        it 'updates game state and returns :tie if no win and board is full' do
            tie_board = [
                Token::EMPTY, Token::O, Token::X, 
                Token::O, Token::O, Token::X, 
                Token::O, Token::X, Token::O
            ]
            updated_tie_board = [Token::X, Token::O, Token::X, Token::O, Token::O, Token::X, Token::O, Token::X, Token::O]
            game.game_state.board.update(position: nil, token: nil, all_positions: tie_board)
            game.play()

            expect(game.game_state.board.positions).to eql updated_tie_board
            expect(game.status).to eql :tie
        end

        it 'updates game state and returns :win if there is a win' do
            win_board = [
                Token::EMPTY, Token::O, Token::O, 
                Token::X, Token::X, Token::O, 
                Token::O, Token::O, Token::X
            ]
            updated_win_board = [Token::X, Token::O, Token::O, Token::X, Token::X, Token::O, Token::O, Token::O, Token::X]
            game.game_state.board.update(position: nil, token: nil, all_positions: win_board)
            game.play()

            expect(game.game_state.board.positions).to eql updated_win_board
            expect(game.status).to eql :win
            expect(game.game_state.current_player.token).to eql Token::X
        end
    end
end 

