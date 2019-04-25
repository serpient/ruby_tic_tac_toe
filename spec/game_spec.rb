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
        before(:all) do
            @game = Game.new(
                board_size: 2,
                player_2: human,
                game_presenter: TestIO.new()
            )
        end
        it 'updates game state and returns :continue if should continue' do
            game.turn()
            expect(game.game_state.board.positions.include?(player_x)).to eql true
        end
    end
end 

