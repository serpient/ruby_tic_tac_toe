require_relative '../token'

class StringBoard
    include Token
    attr_accessor :board, :output

    def generate
        p = string_positions(board.positions)
        string_board = board.size == 3 ? three_by_three(p) : four_by_four(p)
        @output = margin_top + string_board + margin_bottom
    end

    private
    def string_positions(positions)
        positions.map do |position|
            if position == empty
                " "
            elsif position == player_x
                "X"
            else
                "O"
            end
        end 
    end

    def three_by_three(p)
        row1 = "1    |2    |3    \n  #{p[0]}  |  #{p[1]}  |  #{p[2]}  \n_____|_____|_____\n"
        row2 = "4    |5    |6    \n  #{p[3]}  |  #{p[4]}  |  #{p[5]}  \n_____|_____|_____\n"
        row3 = "7    |8    |9    \n  #{p[6]}  |  #{p[7]}  |  #{p[8]}  \n     |     |     \n"
        row1 + row2 + row3
    end

    def four_by_four(p)
        row1 =
        "1    |2    |3    |4    \n  #{p[0]}  |  #{p[1]}  |  #{p[2]}  |  #{p[3]}  \n_____|_____|_____|_____\n"
  
        row2 =
        "5    |6    |7    |8    \n  #{p[4]}  |  #{p[5]}  |  #{p[6]}  |  #{p[7]}  \n_____|_____|_____|_____\n"
  
        row3 =
        "9    |10   |11   |12   \n  #{p[8]}  |  #{p[9]}  |  #{p[10]}  |  #{p[11]}  \n_____|_____|_____|_____\n"
  
        row4 =
        "13   |14   |15   |16   \n  #{p[12]}  |  #{p[13]}  |  #{p[14]}  |  #{p[15]}  \n     |     |     |     \n"
        row1 + row2 + row3 + row4
    end

    def margin_top
        "\n"
    end

    def margin_bottom
        "\n\n\n"
    end
end