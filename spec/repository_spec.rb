require_relative '../lib/repository/repository'
require_relative '../lib/repository/memory'
require_relative '../lib/repository/local'
require_relative '../lib/game'
require_relative './persistence/helper'

describe 'Repository - Memory' do
    attr_accessor :repository
    before(:each) do
        @repository = Repository.new(storage: Memory.new(:test))
    end
    context 'initialize' do
        it 'sets storage' do
            expect(repository.storage.is_a?(Memory)).to eq true
        end

        it 'has a hash and access to DB attribute' do
            expect(repository.db.is_a?(Hash)).to eq true
        end
    end

    context 'save' do
        it 'adds a new row to db' do
            serialized_lite_3_output = JSON.dump({
                "board_positions":["X","empty","empty","O","empty","X","empty","empty","empty"],
            })
            repository.save(serialized_lite_3_output)
            new_data = repository.retrieve_all
            expect(new_data.length).to eq 1
            expect(new_data[0][:game_data]).to eq serialized_lite_3_output
        end
    end

    context 'retrieve_all' do
        it 'returns result by newest to oldest' do
            output_1 = JSON.dump({
                "game_mode":"L",
            })
            output_2 = JSON.dump({
                "game_mode":"R",
            })
            output_3 = JSON.dump({
                "game_mode":"V",
            })
            repository.save(output_1)
            repository.save(output_2)
            repository.save(output_3)
            all_data = repository.retrieve_all
            expect(all_data[0][:game_data]).to eq output_3
            expect(all_data[1][:game_data]).to eq output_2
            expect(all_data[2][:game_data]).to eq output_1
        end
    end

    context 'retrieve_list' do
        it 'retrieves a list of id/created_at items' do
            output_1 = JSON.dump({
                "game_mode":"L",
            })
            repository.save(output_1)
            expect(repository.retrieve_list[0].is_a?(Integer)).to eq true
        end
    end
end

describe 'Repository - Local' do
    attr_accessor :repository
    before(:each) do
        @repository = Repository.new(storage: Local.new(:test))
    end
    after(:each) do
        repository.disconnect
    end
    context 'initialize' do
        it 'sets storage' do
            expect(repository.storage.is_a?(Local)).to eq true
        end

        it 'connects to local DB and access to DB attribute' do
            expect(repository.db.is_a?(Sequel::Postgres::Database)).to eq true
        end
    end

    context 'save' do
        it 'adds a new row to db' do
            serialized_lite_3_output = JSON.dump({
                "board_positions":["X","empty","empty","O","empty","X","empty","empty","empty"],
            })
            repository.save(serialized_lite_3_output)
            new_data = repository.retrieve_all
            expect(new_data.length).to eq 1
            expect(new_data[0][:game_data]).to eq serialized_lite_3_output
        end
    end

    context 'retrieve_all' do
        it 'returns array' do
            expect(repository.retrieve_all.is_a?(Array)).to eq true
        end

        it 'returns result by newest to oldest' do
            output_1 = JSON.dump({
                "game_mode":"L",
            })
            output_2 = JSON.dump({
                "game_mode":"R",
            })
            output_3 = JSON.dump({
                "game_mode":"V",
            })
            repository.save(output_1)
            repository.save(output_2)
            repository.save(output_3)
            all_data = repository.retrieve_all
            expect(all_data[0][:game_data]).to eq output_3
            expect(all_data[1][:game_data]).to eq output_2
            expect(all_data[2][:game_data]).to eq output_1
        end
    end

    context 'retrieve_by_id' do
        it 'returns a result by id' do
            output_1 = JSON.dump({
                "game_mode":"L",
            })
            repository.save(output_1)
            expect(repository.retrieve_by_id(1)[:game_data]).to eq output_1
        end
    end

    context 'retrieve_list' do
        it 'retrieves a list of id/created_at items' do
            output_1 = JSON.dump({
                "game_mode":"L",
            })
            repository.save(output_1)
            expect(repository.retrieve_list[0][0].is_a?(Integer)).to eq true
        end
    end
end