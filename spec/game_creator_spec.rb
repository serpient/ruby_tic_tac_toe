require_relative '../lib/game_creator'

describe 'GameCreator' do
    context 'create' do
        it 'outputs a game instance' do
            game_creator = GameCreator.new(repository_type: Local.new(:tic_tac_toe), game_io: GameIO.new(presenter: TestIO.new))
            new_game = game_creator.create
            expect(new_game.is_a?(Game)).to eq true
        end
    end
end