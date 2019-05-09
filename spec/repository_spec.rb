require_relative '../lib/repository/repository'
require_relative '../lib/repository/memory'
require_relative '../lib/repository/local'
require_relative '../lib/game'
require_relative './persistence/helper'

describe 'Repository - Memory' do
    context 'initialize' do
        it 'sets storage' do
            repository = Repository.new(storage: Memory.new(:test))
            expect(repository.storage.is_a?(Memory)).to eq true
        end

        it 'has a hash and access to DB attribute' do
            repository = Repository.new(storage: Memory.new(:test))
            expect(repository.db.is_a?(Hash)).to eq true
        end
    end

    context 'save' do
        it 'adds a new row to db' do
            repository = Repository.new(storage: Memory.new(:test))
            SERIALIZED_LITE_3_OUTPUT = JSON.dump({
                "board_positions":["X","empty","empty","O","empty","X","empty","empty","empty"],
            })
            repository.save(SERIALIZED_LITE_3_OUTPUT)
            new_data = repository.retrieve_all
            expect(new_data.length).to eq 1
            expect(new_data[0][:game_data]).to eq SERIALIZED_LITE_3_OUTPUT
        end
    end

    context 'retrieve_all' do
        it 'returns result by newest to oldest' do
            repository = Repository.new(storage: Memory.new(:test))
            OUTPUT_1 = JSON.dump({
                "game_mode":"L",
            })
            OUTPUT_2 = JSON.dump({
                "game_mode":"R",
            })
            OUTPUT_3 = JSON.dump({
                "game_mode":"V",
            })
            repository.save(OUTPUT_1)
            repository.save(OUTPUT_2)
            repository.save(OUTPUT_3)
            all_data = repository.retrieve_all
            expect(all_data[0][:game_data]).to eq OUTPUT_3
            expect(all_data[1][:game_data]).to eq OUTPUT_2
            expect(all_data[2][:game_data]).to eq OUTPUT_1
        end
    end
end

describe 'Repository - Local' do
    context 'initialize' do
        it 'sets storage' do
            repository = Repository.new(storage: Local.new(:test))
            expect(repository.storage.is_a?(Local)).to eq true
        end

        it 'connects to local DB and access to DB attribute' do
            repository = Repository.new(storage: Local.new(:test))
            expect(repository.db.is_a?(Sequel::Postgres::Database)).to eq true
        end
    end

    context 'save' do
        it 'adds a new row to db' do
            repository = Repository.new(storage: Local.new(:test))
            SERIALIZED_LITE_3_OUTPUT = JSON.dump({
                "board_positions":["X","empty","empty","O","empty","X","empty","empty","empty"],
            })
            repository.save(SERIALIZED_LITE_3_OUTPUT)
            new_data = repository.retrieve_all
            expect(new_data.length).to eq 1
            expect(new_data[0][:game_data]).to eq SERIALIZED_LITE_3_OUTPUT
        end
    end

    context 'retrieve_all' do
        it 'returns array' do
            repository = Repository.new(storage: Local.new(:test))
            expect(repository.retrieve_all.is_a?(Array)).to eq true
        end

        it 'returns result by newest to oldest' do
            repository = Repository.new(storage: Local.new(:test))
            OUTPUT_1 = JSON.dump({
                "game_mode":"L",
            })
            OUTPUT_2 = JSON.dump({
                "game_mode":"R",
            })
            OUTPUT_3 = JSON.dump({
                "game_mode":"V",
            })
            repository.save(OUTPUT_1)
            repository.save(OUTPUT_2)
            repository.save(OUTPUT_3)
            all_data = repository.retrieve_all
            expect(all_data[0][:game_data]).to eq OUTPUT_3
            expect(all_data[1][:game_data]).to eq OUTPUT_2
            expect(all_data[2][:game_data]).to eq OUTPUT_1
        end
    end

    context 'retrieve_by_id' do
        it 'returns a result by id' do
            repository = Repository.new(storage: Local.new(:test))
            OUTPUT_1 = JSON.dump({
                "game_mode":"L",
            })
            repository.save(OUTPUT_1)
            expect(repository.retrieve_by_id(1)[:game_data]).to eq OUTPUT_1
        end
    end
end