require_relative '../lib/game_setting/game_setting'
require_relative '../lib/game_setting/opponent_type'
require_relative '../lib/game_setting/board_size'
require_relative '../lib/game_setting/setting_types'
require_relative '../lib/player/player_types'
require_relative '../lib/game_setting_setter'
require_relative '../lib/game_presenter/test_io'

describe 'Game Setting Setter' do
    include PlayerType
    include SettingTypes
    
    attr_accessor :game_setting_setter

    setting_types = [
        GameSetting.new(setting: BoardSize.new()),
        GameSetting.new(setting: OpponentType.new()),
    ]

    before(:all) do
        @game_setting_setter = GameSettingSetter.new(
            setting_types: setting_types,
            game_presenter: TestIO.new()
        )
    end

    context 'initialize' do
        
        it 'has array of setting types' do
            expect(game_setting_setter.setting_types.length).to eql 2
        end

        it 'sets presenter' do
            expect(game_setting_setter.game_presenter.is_a?(TestIO)).to eql true
        end

        it 'sets settings' do
            expect(game_setting_setter.settings[:opponent_type]).to eql human
        end
    end

    context 'gets' do
        it 'retrieves settings input' do
            game_setting_setter.gets
            resulting = { :opponent_type => human, :board_size => 3}
            expect(game_setting_setter.settings).to eql resulting
            expect(game_setting_setter.settings[:opponent_type]).to eql human
        end
    end
end