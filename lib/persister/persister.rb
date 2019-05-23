require_relative '../repository/repository';
require_relative './game_serializer';
require_relative './reinitializer';
require_relative '../game';

class Persister
    attr_accessor :repository
    def initialize(repository_type:)
        @repository = Repository.new(storage: repository_type)
    end

    def suspend(game)
        @serializer = GameSerializer.new(game)
        serialized_data = serializer.serialize(game: game)
        repository.save(serialized_data)
        get_recent_game_id
    end

    def resume(game_id:)
        serializer = GameSerializer.new(Game.new(board_size: 3, player_2: "H"))
        json_game_data = repository.retrieve_by_id(game_id)
        game_data = json_game_data[:game_data]
        deserialized_data = serializer.deserialize(json: game_data)
        Reinitializer.generate(game_data: deserialized_data)
    end

    def get_list_of_suspended_games
        repository.retrieve_list
    end

    def has_saved_games?(list)
        list.length > 0
    end

    def suspended_game_ids(list)
        list.map do |data|
            data[0].to_i
        end
    end

    private
    attr_accessor :serializer
    def get_recent_game_id
        repository.retrieve_all[0][:id]
    end
end