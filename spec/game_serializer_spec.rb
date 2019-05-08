require_relative '../lib/persister/game_serializer'
require_relative '../lib/game'
require 'json'

describe 'GameSerializer - Lite 3 Mode - With Moves' do
    attr_accessor :game_serializer, :game

    before(:each) do
        @game = Game.new(
            board_size: 3,
            player_2: PlayerType::HUMAN,
            game_io: TestIO.new,
            board_presenter: StringBoard.new,
            game_mode: "L"
        )
        update_board(game)
        @game_serializer = GameSerializer.new(game)
    end

    context 'serialize' do
        it 'takes in game instance and outputs JSON version of data' do
            expect(game_serializer.serialize(game: game)).to eq JSON.dump(SERIALIZED_LITE_3_OUTPUT)
        end
    end

    context 'deserialze' do
        it 'takes in JSON and outputs game data' do
            json = game_serializer.serialize(game: game)
            expect(game_serializer.deserialize(json: json)).to eq deserialized_output(game)
        end
    end
end

describe 'GameSerializer - Lite 3 Mode - No Moves' do
    attr_accessor :game_serializer, :game

    before(:each) do
        @game = Game.new(
            board_size: 3,
            player_2: PlayerType::HUMAN,
            game_io: TestIO.new,
            board_presenter: StringBoard.new,
            game_mode: "L"
        )
        @game_serializer = GameSerializer.new(game)
    end

    context 'serialize' do
        it 'takes in game instance and outputs JSON version of data' do
            expect(game_serializer.serialize(game: game)).to eq JSON.dump(SERIALIZED_LITE_3_NO_MOVES_OUTPUT)
        end
    end

    context 'deserialze' do
        it 'takes in JSON and outputs game data' do
            json = game_serializer.serialize(game: game)
            expect(game_serializer.deserialize(json: json)).to eq deserialized_output(game)
        end
    end
end

describe 'GameSerializer - Regular Mode' do
    attr_accessor :game_serializer, :game

    before(:each) do
        @game = Game.new(
            board_size: 3,
            player_2: PlayerType::HUMAN,
            game_io: TestIO.new,
            board_presenter: StringBoard.new,
            game_mode: "R"
        )
        update_board(game)
        @game_serializer = GameSerializer.new(game)
    end

    context 'serialize' do
        it 'takes in game instance and outputs JSON version of data' do
            expect(game_serializer.serialize(game: game)).to eq JSON.dump(SERIALIZED_REGULAR_OUTPUT)
        end
    end

    context 'deserialze' do
        it 'takes in JSON and outputs game data' do
            json = game_serializer.serialize(game: game)
            expect(game_serializer.deserialize(json: json)).to eq deserialized_output(game)
        end
    end
end

def update_board(game)
    game.game_state.update(position: 0)
    game.game_state.switch_players
    game.game_state.update(position: 3)
    game.game_state.switch_players
    game.game_state.update(position: 5)
end

def lite_3_mode?(game)
    game.game_state.game_mode.is_a?(Lite3)
end

def deserialized_output(game)
    {
        :board_presenter => game.board_presenter.presenter.class.name,
        :status => game.status,
        :game_mode => game.game_state.game_mode.type,
        :board_positions => game.game_state.board.positions,
        :board_size => game.game_state.board.size,
        :current_player_type => game.game_state.current_player.player.type,
        :current_player_token => game.game_state.current_player.player.token,
        :player_2 => game.game_state.player_2.player.type,
        :player_1_moves => lite_3_mode?(game) && game.game_state.game_mode.player_1_moves,
        :player_2_moves => lite_3_mode?(game) && game.game_state.game_mode.player_2_moves,
    }
end

SERIALIZED_LITE_3_OUTPUT = {
    "board_presenter":"StringBoard",
    "status":"play",
    "game_mode":"L",
    "board_positions":["X","empty","empty","O","empty","X","empty","empty","empty"],
    "board_size":3,
    "current_player_type":"H",
    "current_player_token":"X",
    "player_2": "H",
    "player_1_moves":[
        {"token":"X","position":0},
        {"token":"X","position":5}
    ],
    "player_2_moves":[{"token":"O","position":3}]
}

SERIALIZED_LITE_3_NO_MOVES_OUTPUT = {
    "board_presenter":"StringBoard",
    "status":"play",
    "game_mode":"L",
    "board_positions":["empty","empty","empty","empty","empty","empty","empty","empty","empty"],
    "board_size":3,
    "current_player_type":"H",
    "current_player_token":"X",
    "player_2": "H",
    "player_1_moves":[],
    "player_2_moves":[]
}

SERIALIZED_REGULAR_OUTPUT = {
    "board_presenter":"StringBoard",
    "status":"play",
    "game_mode":"R",
    "board_positions":["X","empty","empty","O","empty","X","empty","empty","empty"],
    "board_size":3,
    "current_player_type":"H",
    "current_player_token":"X",
    "player_2": "H",
    "player_1_moves":false,
    "player_2_moves":false
}