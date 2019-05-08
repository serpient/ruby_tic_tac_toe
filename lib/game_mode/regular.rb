require_relative './game_mode_types'

class Regular
    def update(board:, position:, current_player:)
        board.update(position: position, token: current_player.token)
    end

    def type
        GameModeTypes::REGULAR_MODE
    end

end