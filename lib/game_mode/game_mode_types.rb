require_relative './regular'
require_relative './lite_3'

module GameModeTypes
    extend self
    
    REGULAR_MODE = "R"
    LITE_3_MODE = "L"
    GAME_MODES = [REGULAR_MODE, LITE_3_MODE]

    def game_mode(type)
        case type
        when REGULAR_MODE
            Regular.new
        when LITE_3_MODE
            Lite3.new
        else
            Regular.new
        end
    end
end