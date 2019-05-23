require_relative '../../lib/persister/game_data'
require_relative './helper'

describe 'GameData' do
    include GameData
    context 'deserializer_types' do
        it 'creates an array of name and deserialize types' do
            expect(GameData.deserializer_types[1]).to include(:deserialize)
            expect(GameData.deserializer_types[1]).to include(:name)
            expect(GameData.deserializer_types[1]).not_to include(:data)
        end
    end

    context 'serializer_types' do
        it 'creates an array of valid name and data types' do
            game = Game.new(
                board_size: 3,
                player_2: PlayerType::HUMAN,
                game_io: TestIO.new,
                board_presenter: StringBoard.new,
                game_mode: "L"
            )
            MockTestHelper.update_board(game)
            serializer_types = GameData.serializer_types(game)
            expect(serializer_types[0][:name]).to eq(:board_presenter)
            expect(serializer_types[0][:data]).to eq("StringBoard")
        end
    end
end