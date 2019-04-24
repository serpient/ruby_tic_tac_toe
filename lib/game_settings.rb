require_relative '../lib/validator'
require_relative '../lib/messages'

class GameSettings
    attr_accessor :setting, :input

    def initialize(setting:)
        @setting = setting
    end

    def is_valid?(input: nil)
        @input = input
        setting.is_valid?(input: input)
    end

    def name()
        setting.name
    end

    def message()
        setting.message
    end

    def clean(input:)
        setting.clean(input: input)
    end
end

class OpponentType
    include Messages
    include Validator
    attr_accessor :name, :message
    
    def initialize()
        @name = "opponent_type"
        @message = opponent_type_msg()
    end

    def is_valid?(input: nil)
        opponent_type_valid?(input: input)
    end

    def clean(input:)
        return input
    end
end

class BoardSize
    include Messages
    include Validator
    attr_accessor :name, :message
    
    def initialize()
        @name = "board_size"
        @message = board_size_msg()
    end

    def is_valid?(input: nil)
        board_size_valid?(input: input)
    end

    def clean(input:)
        return input.to_i
    end
end