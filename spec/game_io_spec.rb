require_relative '../lib/game_io/game_io'
require_relative '../lib/game_io/test_io'
require_relative '../lib/game_io/console_io'

describe 'Game IO' do
    context 'Initialization' do
        game_io = GameIO.new(
            presenter: ConsoleIO.new
        )
        it 'sets presenter' do
            expect(game_io.presenter.is_a?(ConsoleIO)).to eq true
        end
    end

    context 'get_input with GameIO' do
        game_io = GameIO.new(
            presenter: TestIO.new
        )
        it 'gets input through presenter' do
            expect(game_io.get_input("1")).to eq "1"
        end
    end

    context 'output_message with ConsoleIO' do
        game_io = GameIO.new(
            presenter: ConsoleIO.new
        )
        it 'through presenter' do
            expect { game_io.output_message("Player") }.to output("Player\n").to_stdout
        end
    end

    context 'output_message with TestIO' do
        game_io = GameIO.new(
            presenter: TestIO.new
        )
        it 'through presenter' do
            expect(game_io.output_message("Player")).to eq "Player\n"
        end
    end
end