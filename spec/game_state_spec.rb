require_relative '../lib/game_state'
require_relative '../lib/player/player_types'

describe 'GameState' do
    include PlayerType
    attr_accessor :game_state

    context 'Initialization' do
        before(:all) do
            @game_state = GameState.new(
                player_1: human,
                player_2: computer,
                board_size: 2
            )
        end

        it 'sets player_1' do
            expect(game_state.player_1.player.is_a?(Human)).to eq true
        end

        it 'sets player_2' do
            expect(game_state.player_2.player.is_a?(Computer)).to eq true
        end

        it 'sets current_player' do
            expect(game_state.current_player).to eq game_state.player_1
        end

        it 'sets new board' do
            expect(game_state.board.positions).to eq [:empty, :empty, :empty, :empty]
        end
    end

    context 'switch_players' do
        it 'switches current player' do
            new_game_state = GameState.new(
                player_1: human,
                player_2: computer,
                board_size: 3
            )
            new_game_state.switch_players()
            expect(new_game_state.current_player).to eq new_game_state.player_2
        end
    end
end