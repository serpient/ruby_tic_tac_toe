require_relative '../lib/game_creator'
require_relative '../lib/persister/persister'
require_relative '../lib/repository/local'

game = GameCreator.new(
    persister: Persister.new(repository_type: Local.new(:tic_tac_toe))
    ).create
game.play