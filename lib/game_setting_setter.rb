require_relative './game_io/game_io'
require_relative './game_io/console_io'
require_relative './game_setting/board_size'
require_relative './game_setting/opponent_type'
require_relative './game_setting/game_setting'
require_relative './messages'

class GameSettingSetter # tic tac toe config wizard
    include Messages
    attr_accessor :settings, :setting_types, :game_io

    INITIAL_SETTING_TYPES = [
            GameSetting.new(setting: BoardSize.new()),
            GameSetting.new(setting: OpponentType.new()),
    ]

    def initialize(
        setting_types: INITIAL_SETTING_TYPES,
        game_io: ConsoleIO.new
    )
        @setting_types = setting_types
        @game_io = game_io
        @settings = gets
    end

    def gets
        setting_types.reduce({}) do |map, setting_type|
            input = nil
            while !setting_type.valid?(input: input)
                input = game_io.game_setting_IO(message: setting_type.message)
            end
            map[setting_type.name] = setting_type.parse(input: input)
            @settings = map
        end
    end
end