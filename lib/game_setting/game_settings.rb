require_relative '../validator'
require_relative '../messages'
require_relative './setting_types'

module GameSettings
    extend self

    include Messages
    include Validator
    include SettingTypes
    
    def types
        [
            game_mode,
            opponent_type,
            board_size
        ]
    end

    def opponent_type
        {
            :name => SettingTypes::OPPONENT_TYPE_SETTING,
            :message => Messages.opponent_type_options,
            :valid? => -> (input: nil) { Validator.opponent_type_valid?(input: input) },
            :parse => -> (input:) { input },
        }
    end

    def board_size
        {
            :name => SettingTypes::BOARD_SIZE,
            :message => Messages.board_size_options,
            :valid? => -> (input: nil) { Validator.board_size_valid?(input: input) },
            :parse => -> (input:) { input.to_i },
        }
    end

    def game_mode
        {
            :name => SettingTypes::GAME_MODE,
            :message => Messages.game_mode_options,
            :valid? => -> (input: nil) { Validator.game_mode_valid?(input: input) },
            :parse => -> (input:) { input },
        }
    end
end