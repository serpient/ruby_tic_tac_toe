require_relative './game'
require_relative './game_setting/game_setting_setter'
require_relative './game_setting/setting_types'
require_relative './persister/persister'
require_relative './repository/local'

class GameCreator
    include SettingTypes

    def initialize(repository_type:, game_io: GameIO.new(presenter: ConsoleIO.new))
        @persister = Persister.new(repository_type: repository_type)
        @game_settings = GameSettingSetter.new(game_io: game_io)
        @suspended_games = persister.get_list_of_suspended_games
    end

    def create
        game_setting_input = get_new_or_suspended_game_input if persister.has_saved_games?(suspended_games)

        return resume_game(game_setting_input) if is_a_suspended_game_id?(game_setting_input)
        return new_game 
    end

    private 
    attr_accessor :persister, :game_settings, :game, :suspended_games

    def get_new_or_suspended_game_input
        suspended_game_ids = persister.suspended_game_ids(suspended_games)
        new_or_suspended_game_settings = GameSettings.new_or_suspended_game(suspended_games, suspended_game_ids)
        setting_output = game_settings.create_settings(settings: new_or_suspended_game_settings)
        setting_output[SettingTypes::NEW_OR_SUSPENDED_GAME]
    end

    def is_a_suspended_game_id?(input)
        input.is_a?(Integer)
    end

    def resume_game(id)
        persister.resume(game_id: id) 
    end

    def new_game
        settings = game_settings.create_settings
        Game.new(
            board_size: settings[SettingTypes::BOARD_SIZE],
            player_2: settings[SettingTypes::OPPONENT_TYPE_SETTING],
            game_mode: settings[SettingTypes::GAME_MODE],
            game_io: game_settings.game_io,
        )
    end
end