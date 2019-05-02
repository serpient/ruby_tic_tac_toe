class TestIO
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
        when 4
            "4"
        else
            array = (0..9).to_a
            array.push("H")
            array.sample
        end
        update_count
        value
    end

    def output_message(message)
        message + "\n"
    end

    def clear
        return
    end

    private
    attr_accessor :count

    def initialize
        @count = 0
    end

    def update_count
        @count += 1
    end
end