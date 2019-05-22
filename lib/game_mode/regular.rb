class Regular
    def update(board:, position:, current_player:)
        board.update(position: position, token: current_player.token)
    end
end