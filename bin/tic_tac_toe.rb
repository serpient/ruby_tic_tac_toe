require_relative '../lib/game_creator'

game = GameCreator.new(repository_type: Local.new(:tic_tac_toe)).create
game.play