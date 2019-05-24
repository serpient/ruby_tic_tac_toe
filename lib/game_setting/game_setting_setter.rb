require_relative '../game_io/game_io'
require_relative '../game_io/console_io'
require_relative '../messages'
require_relative './game_settings'
require_relative './setting_types'

class GameSettingSetter
    include GameSettings
    include Messages
    include SettingTypes

    attr_accessor :setting_types, :game_io

    def initialize(
        setting_types: GameSettings.types,
        game_io: GameIO.new(presenter: ConsoleIO.new)
    )
        @setting_types = setting_types
        @game_io = game_io
    end

    def create_settings(settings: setting_types)
        return settings.reduce({}) do |map, setting_type|
            input = nil
            while !setting_type.fetch(:valid?).(input: input)
                input = game_setting_IO(message: setting_type.fetch(:message))
            end
            map[setting_type.fetch(:name)] = setting_type.fetch(:parse).(input: input)
            map
        end
    end
    
    private
    def game_setting_IO(message:)
        game_io.clear
        game_io.output_message(Messages.start_banner)
        game_io.output_message(message)
        game_io.input
    end
end