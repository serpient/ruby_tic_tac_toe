class TestIO
    attr_accessor :count

    def initialize()
        @count = 0
    end

    def update_count()
        @count += 1
    end

    def get_input(input=nil)
        return input if input != nil

        value = case count 
        when 0
            "4"
        when 1
            "H"
        when 2
            "0"
        when 3
            "3"
        else
            array = (0..4).to_a
            array.push("H")
            array.sample
        end
        update_count()
        return value
    end

    def output_message(message)
        message + "\n"
    end

    def clear()
        return
    end

    def game_setting_IO(message:)
        return get_input
    end
end