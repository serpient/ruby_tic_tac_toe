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

    def game_setting_IO(message:)
        clear
        output_message(start_banner)
        output_message(message)
        get_input
    end

    def output_board(board:, board_presenter:)
        game_io.clear
        board_presenter.generate(board: board)
        game_io.output_message(board_presenter.output)
    end
end