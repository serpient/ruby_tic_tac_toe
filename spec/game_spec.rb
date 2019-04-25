require_relative '../lib/game'
require_relative '../lib/game_state'
require_relative '../lib/player'
require_relative '../lib/game_presenter'
require_relative '../lib/game_setting'

describe 'Game' do
    include PlayerType
    include Token
    attr_accessor :game

    context "Initialization" do
        before(:all) do
            @game = Game.new(
                board_size: 3,
                player_2: human,
                game_presenter: TestIO.new()
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

    context "Turn" do
        before(:each) do
            @game = Game.new(
                board_size: 3,
                player_2: computer,
                game_presenter: TestIO.new()
            )
        end
        it 'updates game state and returns :continue if should continue' do
            game.turn()
            expect(game.game_state.board.positions.include?(player_x)).to eql true
        end

        it 'updates game state and returns :tie if no win and board is full' do
            tie_board = [
                empty, player_o, player_x, 
                player_o, player_o, player_x, 
                player_o, player_x, player_o
            ]
            updated_tie_board = [player_x, player_o, player_x, player_o, player_o, player_x, player_o, player_x, player_o]
            game.game_state.board.update(position: nil, token: nil, all_positions: tie_board)
            game.turn()
            expect(game.game_state.board.positions).to eql updated_tie_board
            expect(game.status).to eql :tie
        end

        it 'updates game state and returns :win if there is a win' do
            win_board = [
                empty, player_o, player_o, 
                player_x, player_x, player_o, 
                player_o, player_o, player_x
            ]
            updated_win_board = [player_x, player_o, player_o, player_x, player_x, player_o, player_o, player_o, player_x]
            game.game_state.board.update(position: nil, token: nil, all_positions: win_board)
            game.turn()
            expect(game.game_state.board.positions).to eql updated_win_board
            expect(game.status).to eql :win
            expect(game.game_state.current_player.token).to eql player_x
        end
    end
end 

