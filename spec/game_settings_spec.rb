require_relative '../lib/game_setting/game_setting'
require_relative '../lib/game_setting/opponent_type'
require_relative '../lib/game_setting/board_size'
require_relative '../lib/game_setting/setting_types'
require_relative '../lib/player/player_types'


describe 'Game Setting' do
    include PlayerType
    include SettingTypes

    context 'Initialize' do
        game_settings = GameSetting.new(
            setting: OpponentType.new()
        )
        it 'sets name' do
            expect(game_settings.name).to eql :opponent_type
        end
        it 'sets setting class' do
            expect(game_settings.setting.is_a?(OpponentType)).to eql true
        end
    end

    context 'opponent type valid' do
        game_settings = GameSetting.new(
            setting: OpponentType.new(),
        )
        it 'returns true if valid' do
            expect(game_settings.valid?(input: human)).to eql true
        end
        it 'returns false if invalid' do
            expect(game_settings.valid?(input: "3")).to eql false
        end
    end

    context 'board size valid' do
        game_settings = GameSetting.new(
            setting: BoardSize.new(),
        )
        it 'returns false if invalid' do
            expect(game_settings.valid?(input: human)).to eql false
        end
        it 'returns true if valid' do
            expect(game_settings.valid?(input: "3")).to eql true
        end
    end
end