require_relative '../lib/game_state'
require_relative '../lib/game_presenter'
require_relative '../lib/messages'
require_relative '../lib/game_setting'

class Game
    include Validator
    include Messages

    attr_accessor :game_state, :game_presenter

    def initialize(game_presenter: ConsoleIO.new)
        @game_presenter = game_presenter
    end

    def set_game_settings(settings:)
        settings.reduce({}) do |map, setting_type|
            input = nil
            while !setting_type.valid?(input: input)
                input = game_presenter.game_setting_IO(message: setting_type.message)
            end
            map[setting_type.name] = setting_type.clean(input: input)
            map
        end
    end

    def start()
        settings = [
            GameSetting.new(setting: BoardSize.new),
            GameSetting.new(setting: OpponentType.new),
        ]
        setting_results = set_game_settings(settings: settings)

        @game_state = GameState.new(
            player_2: setting_results["opponent_type"],
            board_size: setting_results["board_size"]
        )
    end
end

