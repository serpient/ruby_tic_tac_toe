require_relative './game_presenter/game_presenter'
require_relative './game_presenter/console_io'
require_relative './game_setting/board_size'
require_relative './game_setting/opponent_type'
require_relative './game_setting/game_setting'
require_relative './messages'

class GameSettingSetter
    include Messages
    attr_accessor :settings, :setting_types, :game_presenter

    INITIAL_SETTING_TYPES = [
            GameSetting.new(setting: BoardSize.new()),
            GameSetting.new(setting: OpponentType.new()),
    ]

    def initialize(
        setting_types: INITIAL_SETTING_TYPES,
        game_presenter: ConsoleIO.new
    )
        @setting_types = setting_types
        @game_presenter = game_presenter
        @settings = gets
    end

    def gets
        setting_types.reduce({}) do |map, setting_type|
            input = nil
            while !setting_type.valid?(input: input)
                input = game_presenter.game_setting_IO(message: setting_type.message)
            end
            map[setting_type.name] = setting_type.clean(input: input)
            @settings = map
        end
    end
end