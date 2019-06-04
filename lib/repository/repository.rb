require_relative './memory'

class Repository
    attr_accessor :storage
    def initialize(storage:)
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

    def retrieve_list
        storage.retrieve_list
    end

    def db
        storage.db
    end

    def disconnect
        storage.disconnect
    end
end