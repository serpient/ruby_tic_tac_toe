require_relative '../lib/player'

describe 'Player' do
    context 'Initialization' do
        player = Player.new(
            opponent_type: :human,
        )
        it 'sets opponent' do
            expect(player.opponent_type).to eq :human
        end

        it 'sets current_player' do
            expect(player.current_player).to eq :hero
        end
    end

    context 'Switch' do
        it 'switches between :hero to :human' do
            player = Player.new(
                opponent_type: :human,
            )
            player.switch()
            expect(player.current_player).to eq :human
        end

        it 'switches between :hero to :ai' do
            player = Player.new(
                opponent_type: :ai,
            )
            player.switch()
            expect(player.current_player).to eq :ai
        end
    end

    context 'Move' do
        it 'gets valid human input' do
            player = Player.new(
                opponent_type: :human,
            )
            board = Board.new(size: 2)
            expect(player.move(board: board)).to eq 4
        end

        it 'gets valid computer input' do
            player = Player.new(
                opponent_type: :ai,
            )
            board = Board.new(size: 2)
            board.update(position: 0, token: :hero)
            board.update(position: 2, token: :hero)
            board.update(position: 3, token: :hero)
            player.switch()
            expect(player.current_player).to eq :ai
            expect(player.move(board: board)).to eq 1
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