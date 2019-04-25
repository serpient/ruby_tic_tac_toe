require_relative '../messages'

class ConsoleIO
    include Messages
    
    def get_input(input=nil)
        return gets.chomp
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
        return get_input
    end
end