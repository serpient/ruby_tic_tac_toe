require_relative './game_rules'
require_relative './messages'
require_relative './validator'
require_relative './input_type'
require_relative './board'
require_relative './token'
require_relative './game_io/console_io'
require_relative './game_mode/game_mode_types'
require_relative './board_presenter/board_presenter'
require_relative './board_presenter/string_board'
require_relative './persister/persister'
require_relative './repository/local'
require_relative './player/player'
require_relative './player/player_types'

class Game
    include Validator
    include Messages
    include GameRules
    include GameModeTypes
    include InputType
    include Token
    include PlayerType

    attr_accessor :status, :board_presenter, :game_type, 
    :player_1, :player_2, :board, :current_player, 
    :game_mode, :player_2_type

    def initialize(
        game_io: ConsoleIO.new, 
        board_size:, 
        player_2:, 
        board_presenter: StringBoard.new,
        game_mode: GameModeTypes::REGULAR_MODE,
        repository_type: Local.new
    )
        @game_io = game_io
        @status = :play
        @board_presenter = BoardPresenter.new(presenter: board_presenter)
        @repository_type = repository_type
        @board = Board.new(size: board_size)
        @player_1 = Player.new(player: PlayerType.player(PlayerType::HUMAN), token: Token::X)
        @player_2 = Player.new(player: PlayerType.player(player_2), token: Token::O)
        @player_2_type = player_2
        @current_player = @player_1
        @game_mode = GameModeTypes.game_mode(game_mode)
        @game_type = game_mode
    end

    def play
        while status == :play
            output_board
            output_save_option
            input = valid_input(board: board, presenter: game_io)
            if input == InputType::SAVE
                @status = :save
            else
                board = update_board(input: input) 
                update_game_status(board: board)
                switch_players if status == :play
            end
        end
        output_board
        return save_game if status == :save
        return output_win if status == :win
        return output_tie if status == :tie 
    end

    def update(position:)
        game_mode.update(
            board: board,
            position: position,
            current_player: current_player
        )
    end
    
    def switch_players
        @current_player = current_player == player_1 ? player_2 : player_1
    end

    private
    attr_accessor :game_io, :repository_type,

    
    def output_board
        game_io.clear
        board_presenter.generate(board: board)
        game_io.output_message(board_presenter.output)
    end

    def output_save_option
        game_io.output_message(Messages.output_save_option)
    end

    def valid_input(board:, presenter:)
        input = -1
        input = current_player.move(board: board, presenter: presenter) while input_not_valid(input: input, board: board) 
        input
    end

    def input_not_valid(input:, board:) 
        !Validator.position_valid?(input: input, board: board) && !Validator.save_game?(input: input)
    end

    def update_board(input:)
        update(position: input.to_i)
        board
    end

    def update_game_status(board:)
        if GameRules.win?(board: board) 
            @status = :win 
        elsif GameRules.tie?(board: board) 
            @status = :tie 
        end
    end

    def output_win
        game_io.output_message(Messages.win(current_player.token))
    end

    def output_tie
        game_io.output_message(Messages.tie) 
    end

    def save_game
        at_exit do
            persister = Persister.new(repository_type: repository_type)
            persister.suspend(self)
            game_io.output_message(Messages.game_save)
        end
    end
end

