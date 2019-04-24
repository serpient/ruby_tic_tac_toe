require_relative '../lib/game_presenter'

describe 'Game Presenter' do
    context 'Initialization' do
        game_presenter = GamePresenter.new(
            presenter: ConsoleIO.new()
        )
        it 'sets presenter' do
            expect(game_presenter.presenter.is_a?(ConsoleIO)).to eq true
        end
    end

    context 'get_input with GameIO' do
        game_presenter = GamePresenter.new(
            presenter: TestIO.new()
        )
        it 'gets input through presenter' do
            expect(game_presenter.get_input("1")).to eq "1"
        end
    end

    context 'output_message with ConsoleIO' do
        game_presenter = GamePresenter.new(
            presenter: ConsoleIO.new()
        )
        it 'through presenter' do
            expect { game_presenter.output_message("Player") }.to output("Player\n").to_stdout
        end
    end

    context 'output_message with TestIO' do
        game_presenter = GamePresenter.new(
            presenter: TestIO.new()
        )
        it 'through presenter' do
            expect(game_presenter.output_message("Player")).to eq "Player\n"
        end
    end
end