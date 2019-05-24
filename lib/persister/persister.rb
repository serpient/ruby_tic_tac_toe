require_relative '../repository/repository';
require_relative './game_serializer';
require_relative './reinitializer';
require_relative '../game';

class Persister
    include GameSerializer
    attr_accessor :repository

    def initialize(repository_type:)
        @repository = Repository.new(storage: repository_type)
    end

    def suspend(game)
        serialized_data = GameSerializer.serialize(game: game)
        repository.save(serialized_data)
        recent_game_id
    end

    def resume(game_id:)
        json_game_data = repository.retrieve_by_id(game_id)
        game_data = json_game_data.fetch(:game_data)
        deserialized_data = GameSerializer.deserialize(json: game_data)
        Reinitializer.generate(game_data: deserialized_data)
    end

    def suspended_games
        repository.retrieve_list
    end

    def has_saved_games?(list)
        list.length > 0
    end

    def suspended_game_ids(list)
        list.map do |suspended_game|
            suspended_game.id.to_i
        end
    end

    private
    attr_accessor :serializer
    def recent_game_id
        repository.retrieve_all[0].fetch(:id)
    end
end