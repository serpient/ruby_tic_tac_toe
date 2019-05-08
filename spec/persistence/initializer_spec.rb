require_relative '../../lib/persister/initializer'
require_relative './helper'

describe 'Initializer - Lite 3 Mode' do
    include Initializer
    attr_accessor :game

    context 'initialize' do
        game = Game.new(
            board_size: 3,
            player_2: PlayerType::HUMAN,
            game_io: TestIO.new,
            board_presenter: StringBoard.new,
            game_mode: "L"
        )
        deserialized_output = MockTestHelper.deserialized_output(game)
        
        it 'recreates an existing game' do
            new_game = Initializer.reinitialize(game_data: deserialized_output)
            expect(new_game.is_a?(Game)).to eq true
        end
    end
end