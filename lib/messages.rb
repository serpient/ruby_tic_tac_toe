module Messages
    def start_banner 
        "\n#{border}#{empty}#{title}#{empty}#{border}\n"
    end

    def board_size_msg
        "           Choose your Board         \n         (3)x3 or (4)x4 board?       \n"
    end

    def opponent_type_msg
        "        Choose your Component        \n   (H)uman or (C)omputer opponent?   \n"
    end

    def choose_position(token)
        "Player #{token}: Choose a valid position: "
    end
    
    def computer_chooses(position, token)
        "Player #{token} chooses position #{position}"
    end

    def win_msg(token)
        "Player #{token} Wins"
    end

    def tie_msg
        "Game is a Tie"
    end

    private
    def border
        "=====================================\n"
    end

    def empty
        "                                     \n                                     \n"
    end

    def title
        "         T I C  T A C  T O E         \n"
    end
end