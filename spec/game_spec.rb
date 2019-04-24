require_relative '../lib/game'
require_relative '../lib/game_state'
require_relative '../lib/player'
require_relative '../lib/game_presenter'
require_relative '../lib/game_settings'

describe 'Game' do
    context 'set game settings' do
        game = Game.new(game_presenter: TestIO.new())
        it 'iterates over a series of game settings and compiles a settings list' do
            settings = [
                GameSettings.new(setting: BoardSize.new()),
                GameSettings.new(setting: OpponentType.new()),
            ]
            resulting = { "opponent_type" => "H", "board_size" => 4}
            expect(game.set_game_settings(settings: settings)).to eql resulting
        end
    end
end 

