require_relative '../lib/game_mode/game_mode_types'
require_relative '../lib/game_mode/regular'
require_relative '../lib/game_mode/lite_3'

describe 'GameModeTypes' do
    include GameModeTypes
    context 'get_game_mode' do
        it 'retrieves regular game mode class' do
            expect(GameModeTypes.get_game_mode("R").is_a?(Regular)). to eq true
        end

        it 'retrieves lite_3 game mode class' do
            expect(GameModeTypes.get_game_mode("L").is_a?(Lite3)). to eq true
        end
    end
end