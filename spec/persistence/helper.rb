module MockTestHelper
    extend self

    def update_board(game)
        game.update(position: 0)
        game.switch_players
        game.update(position: 3)
        game.switch_players
        game.update(position: 5)
        game.switch_players
    end
    
    def lite_3_mode?(game)
        game.game_mode.is_a?(Lite3)
    end
    
    def positions(game)
        game.board.positions
    end

    def current_player_token(game)
        game.current_player.player.token
    end

    def player_1_moves(game)
        game.game_mode.player_1_moves
    end

    def player_2_moves(game)
        game.game_mode.player_2_moves
    end

    def deserialized_output(game)
        {
            :status => game.status,
            :game_mode => game.game_mode.type,
            :board_positions => positions(game),
            :board_size => game.board.size,
            :current_player_token => game.current_player.player.token,
            :player_2 => game.player_2.player.type,
            :player_1_moves => lite_3_mode?(game) && player_1_moves(game),
            :player_2_moves => lite_3_mode?(game) && player_2_moves(game),
        }
    end
end