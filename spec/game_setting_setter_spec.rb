require_relative '../lib/player/player_types'
require_relative '../lib/game_setting/game_setting_setter'
require_relative '../lib/game_io/test_io'

describe 'Game Setting Setter' do
    include PlayerType
    # include SettingTypes
    
    attr_accessor :game_setting_setter

    before(:each) do
        @game_setting_setter = GameSettingSetter.new(
            game_io: TestIO.new()
        )
    end

    context 'initialize' do
        it 'sets presenter' do
            expect(game_setting_setter.game_io.is_a?(TestIO)).to eql true
        end
    end

    context 'create_settings' do
        it 'retrieves settings input' do
            game_setting_setter.create_settings
            resulting = { :opponent_type => human, :board_size => 4}
            expect(game_setting_setter.settings).to eql resulting
            expect(game_setting_setter.settings[:opponent_type]).to eql human
        end
    end
end