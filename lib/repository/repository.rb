require_relative './memory'

class Repository
    attr_accessor :storage
    def initialize(storage:, table: :tic_tac_toe)
        @storage = storage
    end

    def save(data)
        storage.save(data)
    end

    def retrieve_by_id(id)
        storage.retrieve_by_id(id)
    end

    def retrieve_all
        storage.retrieve_all
    end

    def db
        storage.db
    end
end