require_relative '../lib/game_state'
require_relative '../lib/player/player_types'
require_relative '../lib/token'
require_relative '../lib/game_setting/setting_types'
require_relative '../lib/game_mode/game_mode_types'

describe 'GameState Regular Mode' do
    include PlayerType
    include Token
    attr_accessor :game_state

    context 'Initialization' do
        before(:each) do
            @game_state = GameState.new(
                player_1: PlayerType::HUMAN,
                player_2: PlayerType::COMPUTER,
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
            expect(game_state.board.positions).to eq [Token::EMPTY, Token::EMPTY, Token::EMPTY, Token::EMPTY]
        end
    end

    context 'switch_players' do
        it 'switches current player' do
            new_game_state = GameState.new(
                player_1: PlayerType::HUMAN,
                player_2: PlayerType::COMPUTER,
                board_size: 3
            )
            new_game_state.switch_players
            expect(new_game_state.current_player).to eq new_game_state.player_2
        end
    end
end

describe 'GameState Lite 3 mode' do
    include PlayerType
    include Token
    include SettingTypes
    include GameModeTypes
    attr_accessor :game_state

    before(:all) do
        @game_state = GameState.new(
            player_1: PlayerType::HUMAN,
            player_2: PlayerType::COMPUTER,
            board_size: 3,
            game_mode: GameModeTypes::LITE_3_MODE
        )
    end

    context 'Initialization' do
        it 'sets game_mode' do
            expect(game_state.game_mode.is_a?(Lite3)).to eq true
        end
    end

    context 'updates' do
        before(:all) do
            @game_state = GameState.new(
                player_1: PlayerType::HUMAN,
                player_2: PlayerType::COMPUTER,
                board_size: 3,
                game_mode: GameModeTypes::LITE_3_MODE
            )
        end

        before(:each) do
            game_state.switch_players
        end

        it 'Player O - 1' do
            game_state.update(position: 0)
            expect(game_state.board.positions).to eq [
                Token::O,Token::EMPTY,Token::EMPTY,
                Token::EMPTY,Token::EMPTY,Token::EMPTY,
                Token::EMPTY,Token::EMPTY,Token::EMPTY
            ]
        end

        it 'Player X - 1' do
            game_state.update(position: 1)
            expect(game_state.board.positions).to eq [
                Token::O,Token::X,Token::EMPTY,
                Token::EMPTY,Token::EMPTY,Token::EMPTY,
                Token::EMPTY,Token::EMPTY,Token::EMPTY
            ]
        end
        

        it 'Player O - 2' do
            game_state.update(position: 2)
            expect(game_state.board.positions).to eq [
                Token::O,Token::X,Token::O,
                Token::EMPTY,Token::EMPTY,Token::EMPTY,
                Token::EMPTY,Token::EMPTY,Token::EMPTY
            ]
        end

        it 'Player X - 2' do
            game_state.update(position: 3)
            expect(game_state.board.positions).to eq [
                Token::O,Token::X,Token::O,
                Token::X,Token::EMPTY,Token::EMPTY,
                Token::EMPTY,Token::EMPTY,Token::EMPTY
            ]
        end


        it 'Player O - 3' do
            game_state.update(position: 4)
            expect(game_state.board.positions).to eq [
                Token::O,Token::X,Token::O,
                Token::X,Token::O,Token::EMPTY,
                Token::EMPTY,Token::EMPTY,Token::EMPTY
            ]
        end

        it 'Player X - 3' do
            game_state.update(position: 5)
            expect(game_state.board.positions).to eq [
                Token::O,Token::X,Token::O,
                Token::X,Token::O,Token::X,
                Token::EMPTY,Token::EMPTY,Token::EMPTY
            ]
        end

        it 'Player O - 4 ; Removes oldest position' do
            game_state.update(position: 6)
            expect(game_state.board.positions).to eq [
                Token::EMPTY,Token::X,Token::O,
                Token::X,Token::O,Token::X,
                Token::O,Token::EMPTY,Token::EMPTY
            ]
        end

        it 'Player X - 4 ; Removes oldest position' do
            game_state.update(position: 0)
            expect(game_state.board.positions).to eq [
                Token::X,Token::EMPTY,Token::O,
                Token::X,Token::O,Token::X,
                Token::O,Token::EMPTY,Token::EMPTY
            ]
        end
    end
end