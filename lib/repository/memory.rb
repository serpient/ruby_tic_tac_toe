class Memory
    attr_accessor :db, :table
    
    def initialize(table_name = :test)
        @db = {table_name => []}
        @table = table_name
    end

    def retrieve_all
        db.fetch(table).sort_by { |data| -data.fetch(:created_at).to_i }
    end

    def retrieve_by_id(id)
        db.fetch(table).find { |value| value.fetch(:id) == id }
    end

    def save(data)
        db.fetch(table).push({
            game_data: data,
            created_at: Time.new(2010,8,10,db.fetch(table).length),
            id: rand(1000)
        })
    end

    def retrieve_list
        retrieve_all.map do |data|
            data.fetch(:id)
        end
    end

    def disconnect
        @db = {}
    end
end