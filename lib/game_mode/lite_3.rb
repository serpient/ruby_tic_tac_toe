require_relative '../token'

class Lite3
    include Token

    def update(board:, position:, current_player:)
        max_num_of_moves = board.size
        current_player_moves = get_player_moves(current_player)

        remember_move(move_collection: current_player_moves, position: position, token: current_player.token)

        if current_player_moves.length > max_num_of_moves
            remove_oldest_move(move_collection: current_player_moves, board: board)
        end

        board.update(position: position, token: current_player.token)
    end

    private
    attr_accessor :player_1_moves, :player_2_moves
    PositionWithIndex = Struct.new(:token, :position)

    def initialize
        @player_1_moves = []
        @player_2_moves = []
    end

    def get_player_moves(current_player)
        current_player.token == Token::X ? player_1_moves : player_2_moves 
    end

    def remember_move(move_collection:, position:, token:)
        move_collection.push(PositionWithIndex.new(token, position))
    end

    def remove_oldest_move(move_collection:, board:)
        move_to_remove = move_collection.shift
        board.update(position: move_to_remove.position, token: Token::EMPTY)
    end
end