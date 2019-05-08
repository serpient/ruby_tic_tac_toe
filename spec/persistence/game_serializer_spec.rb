require_relative '../../lib/persister/game_serializer'
require_relative '../../lib/game'
require_relative './helper'
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
        MockTestHelper.update_board(game)
        @game_serializer = GameSerializer.new(game)
    end

    context 'serialize' do
        it 'takes in game instance and outputs JSON version of data' do
            SERIALIZED_LITE_3_OUTPUT = {
                "board_presenter":"StringBoard",
                "status":"play",
                "game_mode":"L",
                "board_positions":["X","empty","empty","O","empty","X","empty","empty","empty"],
                "board_size":3,
                "current_player_token":"O",
                "player_2":"H",
                "player_1_moves":[
                    {"token":"X","position":0},
                    {"token":"X","position":5}
                ],
                "player_2_moves":[{"token":"O","position":3}]
            }
            expect(game_serializer.serialize(game: game)).to eq JSON.dump(SERIALIZED_LITE_3_OUTPUT)
        end
    end

    context 'deserialze' do
        it 'takes in JSON and outputs game data' do
            json = game_serializer.serialize(game: game)
            expect(game_serializer.deserialize(json: json)).to eq MockTestHelper.deserialized_output(game)
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
            SERIALIZED_LITE_3_NO_MOVES_OUTPUT = {
                "board_presenter":"StringBoard",
                "status":"play",
                "game_mode":"L",
                "board_positions":["empty","empty","empty","empty","empty","empty","empty","empty","empty"],
                "board_size":3,
                "current_player_token":"X",
                "player_2":"H",
                "player_1_moves":[],
                "player_2_moves":[]
            }
            expect(game_serializer.serialize(game: game)).to eq JSON.dump(SERIALIZED_LITE_3_NO_MOVES_OUTPUT)
        end
    end

    context 'deserialze' do
        it 'takes in JSON and outputs game data' do
            json = game_serializer.serialize(game: game)
            expect(game_serializer.deserialize(json: json)).to eq MockTestHelper.deserialized_output(game)
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
        MockTestHelper.update_board(game)
        @game_serializer = GameSerializer.new(game)
    end

    context 'serialize' do
        it 'takes in game instance and outputs JSON version of data' do
            SERIALIZED_REGULAR_OUTPUT = {
                "board_presenter":"StringBoard",
                "status":"play",
                "game_mode":"R",
                "board_positions":["X","empty","empty","O","empty","X","empty","empty","empty"],
                "board_size":3,
                "current_player_token":"O",
                "player_2":"H",
                "player_1_moves":false,
                "player_2_moves":false
            }
            expect(game_serializer.serialize(game: game)).to eq JSON.dump(SERIALIZED_REGULAR_OUTPUT)
        end
    end

    context 'deserialize' do
        it 'takes in JSON and outputs game data' do
            json = game_serializer.serialize(game: game)
            expect(game_serializer.deserialize(json: json)).to eq MockTestHelper.deserialized_output(game)
        end
    end
end