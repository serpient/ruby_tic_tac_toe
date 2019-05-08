require_relative '../game_mode/lite_3';

class GameData
    def initialize(game)
        @game = game
    end

    def types
        [
            board_presenter,
            status,
            game_mode,
            board_positions,
            board_size,
            current_player_type,
            current_player_token,
            player_1_moves,
            player_2_moves
        ]
    end

    private
    attr_accessor :game

    def board_presenter
        {
            name: :board_presenter,
            data: game.board_presenter.presenter.class.name
        }
    end

    def status
        {
            name: :status,
            data: game.status,
            deserialize: -> (string) { convert_to_symbol(string) }
        }
    end

    def game_mode
        {
            name: :game_mode,
            data: game.game_state.game_mode.class.name,
        }
    end

    def board_positions
        {
            name: :board_positions,           
            data: game.game_state.board.positions,
            deserialize: -> (array) { array.map { |string| convert_to_symbol(string) } },
        }
    end

    def board_size
        {
            name: :board_size,   
            data: game.game_state.board.size,
        }
    end

    def current_player_type
        {
            name: :current_player_type,   
            data: game.game_state.current_player.player.class.name,
        }
    end

    def current_player_token
        {
            name: :current_player_token,   
            data: game.game_state.current_player.player.token,
            deserialize: -> (string) { convert_to_symbol(string) }
        }
    end

    
    def player_1_moves
        lite_3_mode = game.game_state.game_mode.is_a?(Lite3)
        {
            name: :player_1_moves,   
            data: lite_3_mode && struct_to_hash(game.game_state.game_mode.player_1_moves),
            deserialize: -> (array) { hash_to_struct(array) }
        }
    end 

    def player_2_moves
        lite_3_mode = game.game_state.game_mode.is_a?(Lite3)
        {
            name: :player_2_moves,  
            data: lite_3_mode && struct_to_hash(game.game_state.game_mode.player_2_moves),
            deserialize: -> (array) { hash_to_struct(array) }
        }
    end 

    def convert_to_symbol(string)
        string.to_sym
    end

    def struct_to_hash(array)
        array.map { |struct| struct.to_h }
    end
    
    def hash_to_struct(array)
        return array if !array
        lite_3 = Lite3.new
        array.map { |hash| lite_3.new_position(token: convert_to_symbol(hash[:token]), position: hash[:position]) }
    end
end