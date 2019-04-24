require_relative '../lib/game_state'
require_relative '../lib/game_presenter'
require_relative '../lib/messages'
require_relative '../lib/game_settings'

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
                print_banner
                game_presenter.output_message(setting_type.message)
                input = game_presenter.get_input
            end
            map[setting_type.name] = setting_type.clean(input: input)
            map
        end
    end

    def print_banner
        game_presenter.clear
        game_presenter.output_message(start_banner)
    end

    def start()
        settings = [
            GameSettings.new(setting: BoardSize.new),
            GameSettings.new(setting: OpponentType.new),
        ]
        setting_results = set_game_settings(settings: settings)

        @game_state = GameState.new(
            player_2: setting_results["opponent_type"],
            board_size: setting_results["board_size"]
        )
    end
end

