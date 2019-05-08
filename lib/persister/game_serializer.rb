require_relative './game_data'
require 'json'

class GameSerializer
    def initialize(game)
        @game_data_types = GameData.new(game).types
    end

    def serialize(game:)
        JSON.dump(collect_game_data(game))
    end

    def deserialize(json:)
        game_data = JSON.parse(json, :symbolize_names => true)
        deserialize_data_fields(game_data)
    end

    private
    attr_accessor :game_data_types

    def collect_game_data(game)
        game_data_types.each.reduce({}) do |data_hash, type|
            data_hash[type.fetch(:name)] = type.fetch(:data)
            data_hash
        end
    end

    def deserialize_data_fields(game_data)
        game_data_types.each do |type|
            if type[:deserialize]
                value = game_data[type.fetch(:name)]
                game_data[type.fetch(:name)] = type[:deserialize].(value)
            end
        end
        game_data
    end
end