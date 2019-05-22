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
            while !setting_type[:valid?].(input: input)
                input = game_setting_IO(message: setting_type[:message])
            end
            map[setting_type[:name]] = setting_type[:parse].(input: input)
            map
        end
    end

    def get_paused_games_input(list_of_saved_games, valid_game_ids)
        setting_map = create_settings(settings: GameSettings.resume_game(list_of_saved_games, valid_game_ids))
        setting_map[SettingTypes::RESUME_GAME_SETTING]
    end

    private
    def game_setting_IO(message:)
        game_io.clear
        game_io.output_message(Messages.start_banner)
        game_io.output_message(message)
        game_io.get_input
    end
end