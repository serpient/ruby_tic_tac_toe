#!/usr/bin/env ruby

require_relative '../lib/game'
require_relative '../lib/game_setting/game_setting_setter'
require_relative '../lib/game_setting/setting_types'

include SettingTypes

game_settings = GameSettingSetter.new
settings = game_settings.create_settings

game = Game.new(
    board_size: settings[SettingTypes::BOARD_SIZE],
    player_2: settings[SettingTypes::OPPONENT_TYPE_SETTING],
    game_io: game_settings.game_io
)
game.play