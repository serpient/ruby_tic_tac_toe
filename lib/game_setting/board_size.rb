require_relative '../validator'
require_relative '../messages'
require_relative './setting_types'

class BoardSize
    include Messages
    include Validator
    include SettingTypes
    attr_accessor :name, :message
    
    def initialize
        @name = BOARD_SIZE
        @message = board_size_msg
    end

    def valid?(input: nil)
        board_size_valid?(input: input)
    end

    def parse(input:)
        input.to_i
    end
end

# doesnt need  to be a class here, can just be an object 
# then put in array and iterate. 

# behavior wasnt changing in each class
# i was doing this to make sure each thing had a particular data layout. 
# but the functions didnt really do much, it wasnt meaninfully different from each other
# if the prblm is about data not semantic differences, than interfaces are not a good abstraction

# for example, a good interface and duck types having wildly different implementations of the same function name
# like test io and console io