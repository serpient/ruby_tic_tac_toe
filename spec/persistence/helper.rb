module MockTestHelper
    extend self

    def update_board(game)
        game.game_state.update(position: 0)
        game.game_state.switch_players
        game.game_state.update(position: 3)
        game.game_state.switch_players
        game.game_state.update(position: 5)
        game.game_state.switch_players
    end
    
    def lite_3_mode?(game)
        game.game_state.game_mode.is_a?(Lite3)
    end
    
    def positions(game)
        game.game_state.board.positions
    end

    def current_player_token(game)
        game.game_state.current_player.player.token
    end

    def player_1_moves(game)
        game.game_state.game_mode.player_1_moves
    end

    def player_2_moves(game)
        game.game_state.game_mode.player_2_moves
    end


    def deserialized_output(game)
        {
            :board_presenter => game.board_presenter.presenter.class.name,
            :status => game.status,
            :game_mode => game.game_state.game_mode.type,
            :board_positions => positions(game),
            :board_size => game.game_state.board.size,
            :current_player_token => game.game_state.current_player.player.token,
            :player_2 => game.game_state.player_2.player.type,
            :player_1_moves => lite_3_mode?(game) && player_1_moves(game),
            :player_2_moves => lite_3_mode?(game) && player_2_moves(game),
        }
    end
end