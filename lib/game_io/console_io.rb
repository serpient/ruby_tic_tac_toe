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
end