require_relative '../lib/game_state'
require_relative '../lib/player'

describe 'GameState' do
    context 'Initialization' do
        game_state = GameState.new(
            player_1: Human.new(),
            player_2: Computer.new(),
            board_size: 2
        )
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
            expect(game_state.board.state).to eq [:empty, :empty, :empty, :empty]
        end

        it 'sets presenter' do
            expect(game_state.presenter.presenter.is_a?(ConsoleIO)).to eq true
        end
    end

    context 'switch_players' do
        it 'switches current player' do
            game_state = GameState.new(
                player_1: Human.new(),
                player_2: Computer.new(),
                board_size: 3
            )
            game_state.switch_players()
            expect(game_state.current_player).to eq game_state.player_2
        end
    end
end