class Memory
    attr_accessor :db, :table
    
    def initialize(table_name = :test)
        @db = {table_name => []}
        @table = table_name
    end

    def retrieve_all
        db[table].sort_by { |data| -data[:created_at].to_i }
    end

    def retrieve_by_id(id)
        db[table].find { |value| value[:id] == id }
    end

    def save(data)
        db[table].push({
            game_data: data,
            created_at: Time.new(2010,8,10,db[table].length),
            id: rand(1000)
        })
        nil
    end

    def retrieve_list
        retrieve_all.map do |data|
            data[:id]
        end
    end

    def disconnect
        initialize_table
    end

    private
    def initialize_table
        @db = {}
    end
end