require_relative './human'
require_relative './computer'
require_relative './smart_computer'

module PlayerType
    extend self
    HUMAN = "H"
    COMPUTER = "D"
    SMART_COMPUTER = "S"

    def get_player(type)
        case type
        when HUMAN
            return Human.new
        when COMPUTER
            return Computer.new
        when SMART_COMPUTER
            return SmartComputer.new
        else
            return Human.new
        end
    end

    def valid_players
        [HUMAN, COMPUTER, SMART_COMPUTER]
    end
end