require_relative '../validator'
require_relative '../messages'
require_relative './setting_types'

class BoardSize
    include Messages
    include Validator
    include SettingTypes
    attr_accessor :name, :message
    
    def initialize
        @name = board_size
        @message = board_size_msg
    end

    def valid?(input: nil)
        board_size_valid?(input: input)
    end

    def clean(input:)
        input.to_i
    end
end