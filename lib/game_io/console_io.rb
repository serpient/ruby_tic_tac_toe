require_relative '../messages'

class ConsoleIO
    include Messages
    
    def get_input(input=nil)
        gets.chomp
    end

    def output_message(message)
        puts message
    end

    def clear
        print "\e[2J\e[f"
    end


    # maybe game setting IO should be moved to game setting
    def game_setting_IO(message:)
        clear
        output_message(start_banner)
        output_message(message)
        get_input
    end

    # this should be moved to Game
    def output_board(board:, board_presenter:)
        clear
        board_presenter.generate(board: board)
        output_message(board_presenter.output)
    end
end