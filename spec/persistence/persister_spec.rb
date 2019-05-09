require_relative './helper'
require_relative '../../lib/persister/persister'
require_relative '../../lib/repository/memory'

describe 'Persistence' do
    context 'initialize' do
        it 'sets repository type' do
            persistence = Persister.new(repository_type: Memory.new(:test))
            expect(persistence.repository.storage.is_a?(Memory)).to eq true
        end
    end

    context 'suspend' do
        it 'saves game_state' do
            game = Game.new(
                board_size: 3,
                player_2: PlayerType::HUMAN,
                game_io: TestIO.new,
                board_presenter: StringBoard.new,
                game_mode: "L"
            )
            MockTestHelper.update_board(game)
            persistence = Persister.new(repository_type: Memory.new(:test))
            expect(persistence.suspend(game).is_a?(Integer)).to eq true
        end
    end

    context 'resume' do
        attr_accessor :restarted_game, :game
        before(:each) do
            persistence = Persister.new(repository_type: Memory.new(:test))
            @game = Game.new(
                board_size: 3,
                player_2: PlayerType::HUMAN,
                game_io: TestIO.new,
                board_presenter: StringBoard.new,
                game_mode: "L"
            )
            MockTestHelper.update_board(game)
            game_id = persistence.suspend(game)
            @restarted_game = persistence.resume(game_id: game_id)
        end
        it 'outputs a game type' do
            expect(restarted_game.is_a?(Game)).to eq true
        end

        it 'knows the correct current player ' do
            expect(restarted_game.game_state.current_player.token).to eq :O
        end

        it 'knows the game mode' do
            expect(restarted_game.game_state.game_mode.is_a?(Lite3)).to eq true
        end

        it 'knows player_1 moves' do
            expect(restarted_game.game_state.game_mode.player_1_moves).to eq MockTestHelper.player_1_moves(game)
        end

        it 'knows player_2 moves' do
            expect(restarted_game.game_state.game_mode.player_2_moves).to eq MockTestHelper.player_2_moves(game)
        end

        it 'knows game status' do
            expect(restarted_game.status).to eq game.status
        end

        it 'knows board positions' do
            expect(restarted_game.game_state.board.positions).to eq MockTestHelper.positions(game)
        end
    end
end