require_relative '../lib/player'

describe 'Player' do
    context 'Initialization' do
        human_player = Player.new(
            player: Human.new(),
            token: :hero
        )
        it 'sets player' do
            expect(human_player.player.is_a?(Human)).to eq true
        end
    end

    context 'Move' do
        it 'gets valid human input' do
            human_player = Player.new(
                player: Human.new(),
                token: :hero
            )
            board = Board.new(size: 2)
            board.update(position: 1, token: :hero)
            board.update(position: 2, token: :hero)
            board.update(position: 3, token: :hero)
            expect(human_player.move(board: board)).to eq 0
        end

        it 'gets valid computer input' do
            computer_player = Player.new(
                player: Computer.new(),
                token: :hero
            )
            board = Board.new(size: 2)
            board.update(position: 0, token: :hero)
            board.update(position: 2, token: :hero)
            board.update(position: 3, token: :hero)
            expect(computer_player.move(board: board)).to eq 1
        end
    end
end 

describe 'Computer' do
    context 'Move' do
        computer = Computer.new()
        board = Board.new(size: 2)
        board.update(position: 0, token: :hero)
        board.update(position: 1, token: :hero)
        board.update(position: 2, token: :hero)
        it 'returns a random empty space' do
            expect(computer.move(board: board)).to eq 3
        end
    end
end