require_relative '../lib/player'

describe 'Player' do
    context 'Initialization' do
        human_player = Player.new(
            player: Human.new(),
            token: :hero,
        )
        it 'sets player' do
            expect(human_player.player.is_a?(Human)).to eq true
        end
    end

    context 'Move' do
        it 'gets human input' do
            human_player = Player.new(
                player: Human.new(),
                token: :hero,
            )
            board = Board.new(size: 2)
            presenter = GamePresenter.new(presenter: TestIO.new())
            expect(human_player.move(board: board, presenter: presenter)).to eq "4"
        end

        it 'gets computer input' do
            computer_player = Player.new(
                player: Computer.new(),
                token: :hero,
            )
            board = Board.new(size: 2)
            presenter = GamePresenter.new(presenter: TestIO.new())
            board.update(position: 0, token: :hero)
            board.update(position: 2, token: :hero)
            board.update(position: 3, token: :hero)

            expect(computer_player.move(board: board, presenter: presenter)).to eq 1
        end
    end
end 

describe 'Computer' do
    context 'Move' do
        computer = Computer.new()
        presenter = GamePresenter.new(presenter: TestIO.new())
        board = Board.new(size: 2)
        board.update(position: 0, token: :hero)
        board.update(position: 1, token: :hero)
        board.update(position: 2, token: :hero)

        it 'returns a random empty space' do
            expect(computer.move(board: board, presenter: presenter)).to eq 3
        end
    end
end