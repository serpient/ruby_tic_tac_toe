require_relative '../lib/player'
require_relative '../lib/token'

describe 'Player' do
    include Token

    context 'Initialization' do
        it 'sets player' do
            human_player = Player.new(
                player: Human.new(),
                token: player_x,
            )
            expect(human_player.player.is_a?(Human)).to eq true
        end
    end

    context 'Move' do
        it 'gets human input' do
            human_player = Player.new(
                player: Human.new(),
                token: player_x,
            )
            board = Board.new(size: 2)
            presenter = GamePresenter.new(presenter: TestIO.new())
            expect(human_player.move(board: board, presenter: presenter)).to eq "4"
        end

        it 'gets computer input' do
            computer_player = Player.new(
                player: Computer.new(),
                token: player_x,
            )
            board = Board.new(size: 2)
            presenter = GamePresenter.new(presenter: TestIO.new())
            board.update(position: 0, token: player_x)
            board.update(position: 2, token: player_x)
            board.update(position: 3, token: player_x)

            expect(computer_player.move(board: board, presenter: presenter)).to eq 1
        end
    end
end 

describe 'Computer' do
    include Token

    context 'Move' do
        it 'returns a random empty space' do
            computer = Computer.new()
            presenter = GamePresenter.new(presenter: TestIO.new())
            board = Board.new(size: 2)
            board.update(position: 0, token: player_x)
            board.update(position: 1, token: player_x)
            board.update(position: 2, token: player_x)
    
            expect(computer.move(board: board, presenter: presenter)).to eq 3
        end
    end
end