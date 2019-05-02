require_relative './human'
require_relative './computer'
require_relative './smart_computer'

module PlayerType
    extend self
    HUMAN = "H"
    COMPUTER = "D"
    SMART_COMPUTER = "S"

    def get_player(type)
        return Human.new if type == HUMAN
        return Computer.new if type == COMPUTER
        return SmartComputer.new if type == SMART_COMPUTER
    end
end