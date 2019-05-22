require_relative './player/player_types'
require_relative './game_setting/setting_types'
require_relative './game_mode/game_mode_types'

module Validator
    extend self
    
    include PlayerType
    include SettingTypes
    include GameModeTypes

    def position_valid?(input:, board:) 
        int = input.to_i
        board_range_valid?(int,board) && board.position_empty?(int)
    end

    def save_game?(input:) 
        input == SettingTypes::SAVE
    end

    def board_range_valid?(int, board)
        int >= 0 && int < board.max_positions
    end
    
    def board_size_valid?(input:)
        int = input.to_i
        int == 3 || int == 4
    end

    def opponent_type_valid?(input:)
        PlayerType.valid_players.include?(input)
    end

    def game_mode_valid?(input:)
        GameModeTypes::GAME_MODES.include?(input)
    end

    def resume_option_valid?(input:, valid_game_ids:)
        input == "N" || valid_game_ids.include?(input.to_i)
    end
end