require_relative '../lib/game'
require_relative '../lib/game_setting/game_setting_setter'
require_relative '../lib/game_setting/setting_types'
require_relative '../lib/persister/persister'
require_relative '../lib/repository/local'

include SettingTypes

persister = Persister.new(repository_type: Local.new(:tic_tac_toe))
game_settings = GameSettingSetter.new

suspended_games = persister.get_list_of_suspended_games
puts "suspended games"
puts suspended_games[0]

if persister.has_saved_games?(suspended_games)
    suspended_games_id = persister.valid_game_ids(suspended_games)
    paused_game_input = game_settings.get_paused_games_input(suspended_games, suspended_games_id)  
end

if paused_game_input.is_a?(Integer)
    game = persister.resume(game_id: paused_game_input) 
else
    settings = game_settings.create_settings
    game = Game.new(
        board_size: settings[SettingTypes::BOARD_SIZE],
        player_2: settings[SettingTypes::OPPONENT_TYPE_SETTING],
        game_mode: settings[SettingTypes::GAME_MODE],
        game_io: game_settings.game_io,
    )
end

game.play