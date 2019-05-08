require_relative '../../lib/persister/reinitializer'
require_relative './helper'

describe 'Reinitializer - Lite 3 Mode - No Moves' do
    include Reinitializer
    attr_accessor :game

    context 'generate' do
        game = Game.new(
            board_size: 3,
            player_2: PlayerType::HUMAN,
            game_io: TestIO.new,
            board_presenter: StringBoard.new,
            game_mode: "L"
        )
        deserialized_output = MockTestHelper.deserialized_output(game)

        existing_game = Reinitializer.generate(game_data: deserialized_output)

        it 'outputs a game class' do
            expect(existing_game.is_a?(Game)).to eq true
        end

        it 'sets the player_2 type' do
            expect(existing_game.game_state.player_2.player.is_a?(Human)).to eq true
        end

        it 'sets the game_mode type' do
            expect(existing_game.game_state.game_mode.is_a?(Lite3)).to eq true
        end

        it 'sets the game status' do
            expect(existing_game.status).to eq :play
        end
    end
end

describe 'Reinitializer - Lite 3 Mode - With Moves' do
    include Reinitializer
    attr_accessor :game

    context 'generate' do
        game = Game.new(
            board_size: 3,
            player_2: PlayerType::HUMAN,
            game_io: TestIO.new,
            board_presenter: StringBoard.new,
            game_mode: "L"
        )
        MockTestHelper.update_board(game)
        deserialized_output = MockTestHelper.deserialized_output(game)

        existing_game = Reinitializer.generate(game_data: deserialized_output)

        it 'sets the board positions' do
            expect(existing_game.game_state.board.positions).to eq MockTestHelper.positions(game)
        end

        it 'sets the current_player' do
            expect(existing_game.game_state.current_player.token).to eq MockTestHelper.current_player_token(game)
        end

        it 'sets the player_1 moves' do
            expect(existing_game.game_state.game_mode.player_1_moves).to eq MockTestHelper.player_1_moves(game)
        end

        it 'sets the player_2 moves' do
            expect(existing_game.game_state.game_mode.player_2_moves).to eq MockTestHelper.player_2_moves(game)
        end
    end
end

describe 'Reinitializer - Regular Mode - Computer Player 2 - Board Size 4' do
    include Reinitializer
    attr_accessor :game

    context 'generate' do
        game = Game.new(
            board_size: 4,
            player_2: PlayerType::COMPUTER,
            game_io: TestIO.new,
            board_presenter: StringBoard.new,
            game_mode: "R"
        )
        MockTestHelper.update_board(game)
        deserialized_output = MockTestHelper.deserialized_output(game)

        existing_game = Reinitializer.generate(game_data: deserialized_output)

        it 'sets the game_mode type' do
            expect(existing_game.game_state.game_mode.is_a?(Regular)).to eq true
        end

        it 'sets the player_2 type' do
            expect(existing_game.game_state.player_2.player.is_a?(Computer)).to eq true
        end

        it 'sets the game board size' do
            expect(existing_game.game_state.board.size).to eq 4
        end
    end
end
