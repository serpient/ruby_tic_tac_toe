module Messages
    extend self
    
    def start_banner 
        "\n#{border}#{space}#{title}#{space}#{border}\n"
    end

    def board_size_options
        "           Choose your Board\n         (3)x3 or (4)x4 board?\n"
    end

    def opponent_type_options
        "         Choose your Opponent:\n         * (H)uman\n         * (D)umb Computer\n         * (S)mart Computer" 
    end

    def game_mode_options
        "         Choose the Game Mode:\n         * (R)egular\n         * (L)ite 3\n" 
    end

    def resume_game_options(saved_games_list)
        game_string = "      Choose a New or Paused Game\n  * (N)ew Game\n"
        saved_games_list.each do |saved_game|
            game_string << "  * (#{saved_game[0]}) #{saved_game[1]}\n"
        end
        game_string
    end

    def choose_position(token)
        "Player #{token}: Choose a valid position: "
    end
    
    def computer_chooses(position, token)
        "Player #{token} chooses position #{position}"
    end

    def output_save_option
        "Enter ! to save and close the game.\n\n"
    end

    def game_save
        "Saving game... \nYou can resume this game when you\nstart a new Tic Tac Toe game.\n\n\nGoodbye!\n\n\n"
    end

    def win(token)
        "Player #{token} Wins"
    end

    def tie
        "Game is a Tie"
    end

    private
    def border
        "=====================================\n"
    end

    def space
        "                                     \n                                     \n"
    end

    def title
        "         T I C  T A C  T O E         \n"
    end
end