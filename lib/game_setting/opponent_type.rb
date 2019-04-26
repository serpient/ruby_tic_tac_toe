require_relative '../validator'
require_relative '../messages'
require_relative './setting_types'

class OpponentType
    include Messages
    include Validator
    include SettingTypes
    attr_accessor :name, :message
    
    def initialize
        @name = OPPONENT_TYPE_SETTING
        @message = opponent_type_msg
    end

    def valid?(input: nil)
        opponent_type_valid?(input: input)
    end

    def parse(input:)
        input
    end
end