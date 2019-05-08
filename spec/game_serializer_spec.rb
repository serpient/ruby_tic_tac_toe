require_relative '../lib/persister/game_serializer'
require_relative '../lib/game'
require 'json'

describe 'GameSerializer - Lite 3 Mode' do
    attr_accessor :game, :lite_3_mode, :deserialized_output, :game_serializer, :seralized_output

    before(:each) do
        @game = Game.new(
            board_size: 3,
            player_2: PlayerType::HUMAN,
            game_io: TestIO.new,
            board_presenter: StringBoard.new,
            game_mode: "L"
        )
        game.game_state.update(position: 0)
        game.game_state.switch_players
        game.game_state.update(position: 3)
        game.game_state.switch_players
        game.game_state.update(position: 5)
        @lite_3_mode = game.game_state.game_mode.is_a?(Lite3)
        @seralized_output = {
            "board_presenter":"StringBoard",
            "status":"play",
            "game_mode":"Lite3",
            "board_positions":["X","empty","empty","O","empty","X","empty","empty","empty"],
            "board_size":3,
            "current_player_type":"Human",
            "current_player_token":"X",
            "player_1_moves":[
                {"token":"X","position":0},
                {"token":"X","position":5}],
            "player_2_moves":[{"token":"O","position":3}]
        }
        @deserialized_output = {
            :board_presenter => game.board_presenter.presenter.class.name,
            :status => game.status,
            :game_mode => game.game_state.game_mode.class.name,
            :board_positions => game.game_state.board.positions,
            :board_size => game.game_state.board.size,
            :current_player_type => game.game_state.current_player.player.class.name,
            :current_player_token => game.game_state.current_player.player.token,
            :player_1_moves => lite_3_mode ? game.game_state.game_mode.player_1_moves : nil,
            :player_2_moves => lite_3_mode ? game.game_state.game_mode.player_2_moves : nil,
        }
        @game_serializer = GameSerializer.new(game)
    end

    context 'serialize' do
        it 'takes in game instance and outputs JSON version of data' do
            expect(game_serializer.serialize(game: game)).to eq JSON.dump(seralized_output)
        end
    end

    context 'deserialze' do
        it 'takes in JSON and outputs game data' do
            json = game_serializer.serialize(game: game)
            expect(game_serializer.deserialize(json: json)).to eq deserialized_output
        end
    end
end