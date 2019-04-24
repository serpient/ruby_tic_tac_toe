require_relative '../lib/game_settings'
require_relative '../lib/player'

describe 'Game Settings' do
    include PlayerType

    context 'Initialize' do
        game_settings = GameSettings.new(
            setting: OpponentType.new()
        )
        it 'sets name' do
            expect(game_settings.name).to eql 'opponent_type'
        end
        it 'sets setting class' do
            expect(game_settings.setting.is_a?(OpponentType)).to eql true
        end
    end

    context 'opponent type is_valid' do
        game_settings = GameSettings.new(
            setting: OpponentType.new(),
        )
        it 'returns true if valid' do
            expect(game_settings.is_valid?(input: human)).to eql true
        end
        it 'returns false if invalid' do
            expect(game_settings.is_valid?(input: "3")).to eql false
        end
    end

    context 'board size is_valid' do
        game_settings = GameSettings.new(
            setting: BoardSize.new(),
        )
        it 'returns false if invalid' do
            expect(game_settings.is_valid?(input: human)).to eql false
        end
        it 'returns true if valid' do
            expect(game_settings.is_valid?(input: "3")).to eql true
        end
    end
end