require_relative '../game_mode/lite_3';

module GameData
    extend self

    def serializer_types(game)
        @game = game
        types.reduce([]) do |array, type|
            array.push({ 
                    name: type.fetch(:name), 
                    data: type.fetch(:data) 
                })
            array
        end
    end

    def deserializer_types
        types.reduce([]) do |array, type|
            if type.fetch(:deserialize, false)
                array.push({ 
                    name: type.fetch(:name), 
                    deserialize: type.fetch(:deserialize) 
                })
            end
            array
        end
    end

    private
    attr_accessor :game

    def types
        [
            status,
            game_mode,
            board_positions,
            board_size,
            current_player_token,
            player_2,
            player_1_moves,
            player_2_moves
        ]
    end

    def status
        {
            name: :status,
            data: game&.status, 
            deserialize: -> (string) { status = convert_to_symbol(string); status = status == :save ? :play : status  }
        }
    end

    def game_mode
        {
            name: :game_mode,
            data: game&.game_type, 
        }
    end

    def board_positions
        {
            name: :board_positions,           
            data: game&.board&.positions,
            deserialize: -> (array) { array.map { |string| convert_to_symbol(string) } },
        }
    end

    def board_size
        {
            name: :board_size,   
            data: game&.board&.size,
        }
    end

    def current_player_token
        {
            name: :current_player_token,   
            data: game&.current_player&.player&.token,
            deserialize: -> (string) { convert_to_symbol(string) }
        }
    end

    def player_2
        {
            name: :player_2,   
            data: game&.player_2_type,
        }
    end

    def player_1_moves
        {
            name: :player_1_moves,   
            data: is_lite_3_mode(game) && struct_to_hash(game.game_mode.player_1_moves),
            deserialize: -> (array) { hash_to_struct(array) }
        }
    end 

    def player_2_moves
        {
            name: :player_2_moves,  
            data: is_lite_3_mode(game) && struct_to_hash(game.game_mode.player_2_moves),
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

    def is_lite_3_mode(game)
        game&.game_mode.is_a?(Lite3)
    end
end