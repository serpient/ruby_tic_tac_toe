class Player
    attr_accessor :opponent_type, :current_player, :human, :computer

    def initialize(opponent_type:) 
        @opponent_type = opponent_type
        @current_player = :hero
        @human = Human.new()
        @computer = Computer.new()
    end

    def switch()    
        switch_current_player()
    end

    def move(board:, player_type: get_player_type())
        player_type.move(board: board)
    end

    private
    def switch_current_player()
        @current_player = current_player == :hero ? opponent_type : :hero
    end

    def get_player_type()
        current_player == :ai ? computer : human
    end
end

class Human 
    def move(board:)
        return 4
    end
end

class Computer 
    def move(board:)
        board.empty_positions().sample()
    end
end