require_relative '../validator'
require_relative '../messages'
require_relative './setting_types'

module GameSettings
    include Messages
    include Validator
    include SettingTypes

    def opponent_type
        {
            :name => OPPONENT_TYPE_SETTING,
            :message => opponent_type_msg,
            :valid? => -> (input: nil) { opponent_type_valid?(input: input) },
            :parse => -> (input:) { input },
        }
    end

    def board_size
        {
            :name => BOARD_SIZE,
            :message => board_size_msg,
            :valid? => -> (input: nil) { board_size_valid?(input: input) },
            :parse => -> (input:) { input.to_i },
        }
    end
end