require_relative './token'
require_relative './player/player'
require_relative './player/player_types'
require_relative './board'
require_relative './game_mode/game_mode_types'

class GameState 
    include Token
    include PlayerType
    include GameModeTypes
    attr_accessor :player_1, :player_2, :board, :current_player, :game_mode
    
    def initialize(
        player_1: PlayerType::HUMAN,
        player_2:,
        board_size:,
        game_mode: GameModeTypes::REGULAR_MODE
    )
        @board = Board.new(size: board_size)
        @player_1 = Player.new(player: PlayerType.get_player(player_1), token: Token::X)
        @player_2 = Player.new(player: PlayerType.get_player(player_2), token: Token::O)
        @current_player = @player_1
        @game_mode = GameModeTypes.get_game_mode(game_mode)
    end

    def switch_players
        @current_player = current_player == player_1 ? player_2 : player_1
    end

    def update(position:)
        game_mode.update(
            board: board,
            position: position,
            current_player: current_player
        )
    end
end