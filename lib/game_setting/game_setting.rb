require_relative '../validator'
require_relative '../messages'
require_relative './setting_types'

class GameSetting
    attr_accessor :setting, :input

    def initialize(setting:)
        @setting = setting
    end

    def valid?(input: nil)
        @input = input
        setting.valid?(input: input)
    end

    def name
        setting.name
    end

    def message
        setting.message
    end

    def clean(input:)
        setting.clean(input: input)
    end
end
