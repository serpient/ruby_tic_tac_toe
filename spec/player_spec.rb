require_relative '../lib/player/player'
require_relative '../lib/player/human'
require_relative '../lib/player/computer'
require_relative '../lib/player/player_types'
require_relative '../lib/token'
require_relative '../lib/game_io/game_io'
require_relative '../lib/game_io/test_io'

describe 'Player' do
    include Token

    context 'Initialization' do
        it 'sets player' do
            human_player = Player.new(
                player: Human.new(),
                token: Token::X,
            )
            expect(human_player.player.is_a?(Human)).to eq true
        end
    end

    context 'move' do
        it 'gets valid human input' do
            human_player = Player.new(
                player: Human.new(),
                token: Token::X,
            )
            board = Board.new(size: 3)
            presenter = GameIO.new(presenter: TestIO.new())
            expect(human_player.move(board: board, presenter: presenter)).to eq "4"
        end

        it 'gets valid computer input' do
            computer_player = Player.new(
                player: Computer.new(),
                token: Token::X,
            )
            board = Board.new(size: 2)
            presenter = GameIO.new(presenter: TestIO.new())
            board.update(position: 0, token: Token::X)
            board.update(position: 2, token: Token::X)
            board.update(position: 3, token: Token::X)

            expect(computer_player.move(board: board, presenter: presenter)).to eq 1
        end
    end
end