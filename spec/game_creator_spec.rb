require_relative '../lib/game_creator'
require_relative './persistence/helper'

describe 'GameCreator' do
    context 'create' do
        it 'outputs a new game instance if theres no saved games' do
            persister_dbl = double("Persister")
            game_io_dbl = double("Game IO")
            allow(persister_dbl).to receive_messages(
                :suspended_games => [], 
                :has_saved_games? => false
            )
            allow(game_io_dbl).to receive_messages(
                :clear => nil, 
                :output_message => nil,
            )
            allow(game_io_dbl).to receive(:input).and_return("R", "H", '3')

            game_creator = GameCreator.new(
                persister: persister_dbl, 
                game_io: game_io_dbl
            )

            new_game = game_creator.create
            expect(new_game.is_a?(Game)).to eq true
            expect(new_game.board.positions).to eq [
                Token::EMPTY, Token::EMPTY, Token::EMPTY,
                Token::EMPTY, Token::EMPTY, Token::EMPTY,
                Token::EMPTY, Token::EMPTY, Token::EMPTY,
            ]
        end

        it 'sets new or resumed game option, with option to choose a new game' do
            persister_dbl = double("Persister")
            game_io_dbl = double("Game IO")
            allow(persister_dbl).to receive_messages(
                :suspended_games => [], 
                :has_saved_games? => true,
                :suspended_game_ids => [1]
            )
            allow(game_io_dbl).to receive_messages(
                :clear => nil, 
                :output_message => nil,
            )
            allow(game_io_dbl).to receive(:input).and_return("N", "R", "H", '3')

            game_creator = GameCreator.new(
                persister: persister_dbl, 
                game_io: game_io_dbl
            )
            new_game = game_creator.create
            expect(new_game.board.positions).to eq [
                Token::EMPTY, Token::EMPTY, Token::EMPTY,
                Token::EMPTY, Token::EMPTY, Token::EMPTY,
                Token::EMPTY, Token::EMPTY, Token::EMPTY,
            ]
        end

        it 'recreates a resumed game' do
            persister_dbl = double("Persister")
            game_io_dbl = double("Game IO")
            board_positions = [
                Token::EMPTY, Token::X, Token::EMPTY,
                Token::EMPTY, Token::EMPTY, Token::X,
                Token::EMPTY, Token::O, Token::EMPTY,
            ]
            game_data = {
                :id => 1,
                :status => :play,
                :game_mode => "R",
                :board_positions => board_positions,
                :board_size => 3,
                :current_player_token => :O,
                :player_2 => "C"
            }
            
            allow(persister_dbl).to receive_messages(
                :suspended_games => [], 
                :has_saved_games? => true,
                :suspended_game_ids => [1],
                :resume => Reinitializer.generate(game_data: game_data)
            )

            allow(game_io_dbl).to receive_messages(
                :clear => nil, 
                :output_message => nil,
            )

            allow(game_io_dbl).to receive(:input).and_return('1')

            game_creator = GameCreator.new(
                persister: persister_dbl, 
                game_io: game_io_dbl
            )
            resumed_game = game_creator.create
            expect(resumed_game.board.positions).to eq board_positions
            expect(resumed_game.current_player.player.token).to eq :O
            expect(resumed_game.player_2_type).to eq "C"
        end
    end
end