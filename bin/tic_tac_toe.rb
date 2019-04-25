#!/usr/bin/env ruby

require_relative '../lib/game'
require_relative '../lib/game_setting_setter'
require_relative '../lib/setting_types'

include SettingTypes

game_settings = GameSettingSetter.new()

game = Game.new(
    board_size: game_settings.settings[board_size],
    player_2: game_settings.settings[opponent_type],
    game_presenter: game_settings.game_presenter
)
game.play()