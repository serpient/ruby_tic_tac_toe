require_relative '../game_io/game_io'
require_relative '../game_io/console_io'
require_relative '../messages'
require_relative './game_settings'

class GameSettingSetter
    include GameSettings
    include Messages

    attr_accessor :setting_types, :game_io

    def initialize(
        setting_types: GameSettings.types,
        game_io: GameIO.new(presenter: ConsoleIO.new)
    )
        @setting_types = setting_types
        @game_io = game_io
    end

    def create_settings
        return setting_types.reduce({}) do |map, setting_type|
            input = nil
            while !setting_type[:valid?].(input: input)
                input = game_setting_IO(message: setting_type[:message])
            end
            map[setting_type[:name]] = setting_type[:parse].(input: input)
            map
        end
    end

    private
    def game_setting_IO(message:)
        game_io.clear
        game_io.output_message(Messages.start_banner)
        game_io.output_message(message)
        game_io.get_input
    end
end