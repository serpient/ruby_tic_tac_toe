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
        
        it 'has array of setting types' do
            expect(game_setting_setter.setting_types.length).to eql 2
        end

        it 'sets presenter' do
            expect(game_setting_setter.game_io.is_a?(TestIO)).to eql true
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