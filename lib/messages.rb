module Messages
    def start_banner 
        border = "=====================================\n"
        empty = "                                     \n                                     \n"
        title = "         T I C  T A C  T O E         \n"

        return "\n#{border}#{empty}#{title}#{empty}#{border}\n"
    end

    def board_size_msg
        return "           Choose your Board         \n         (3)x3 or (4)x4 board?       \n"
    end

    def opponent_type_msg
        return "        Choose your Component        \n   (H)uman or (C)omputer opponent?   \n"
    end

    def choose_position(token)
        return "Player #{token}: Choose a valid position: "
    end
    
    def computer_chooses(position, token)
        return "Player #{token} chooses position #{position}"
    end

    def win_msg(token)
        return "Player #{token} Wins"
    end

    def tie_msg
        return "Game is a Tie"
    end
end