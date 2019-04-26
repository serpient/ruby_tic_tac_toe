require_relative '../game_io/game_io'
require_relative '../game_io/console_io'
require_relative '../validator'
require_relative '../messages'
require_relative './setting_types'
require_relative './game_settings'

class GameSettingSetter
    include Messages
    include Validator
    include SettingTypes
    include GameSettings
    attr_accessor :settings, :setting_types, :game_io

    def initialize(
        setting_types: [
            board_size,
            opponent_type,
        ],
        game_io: ConsoleIO.new
    )
        @setting_types = setting_types
        @game_io = game_io
    end

    def create_settings
        setting_types.reduce({}) do |map, setting_type|
            input = nil
            while !setting_type[:valid?].(input: input)
                input = game_io.game_setting_IO(message: setting_type[:message])
            end
            map[setting_type[:name]] = setting_type[:parse].(input: input)
            @settings = map
        end
    end
end