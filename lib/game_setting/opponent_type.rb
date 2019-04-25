require_relative '../validator'
require_relative '../messages'
require_relative './setting_types'

class OpponentType
    include Messages
    include Validator
    include SettingTypes
    attr_accessor :name, :message
    
    def initialize
        @name = opponent_type
        @message = opponent_type_msg
    end

    def valid?(input: nil)
        opponent_type_valid?(input: input)
    end

    def clean(input:)
        return input
    end
end