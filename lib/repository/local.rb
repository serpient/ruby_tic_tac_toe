require 'sequel'

class Local
    attr_accessor :db, :table

    def initialize(table_name)
        @db = Sequel.connect('postgres://postgres:postgres@localhost/postgres')
        @table = table_name.to_sym
        clean_table if table == :test
    end

    def retrieve_all
        retrieve_all_fields.to_a
    end

    def retrieve_by_id(id)
        retrieve_game_data_by_id(id).to_a[0]
    end

    def save(data)
        save_game_data(data)
    end

    def retrieve_list
        retrieve_id_and_date.to_a.map do |game_log|
            game_log[:id]
        end
    end

    private
    def clean_table
        drop_table
        create_table
    end
    
    def save_game_data(data)
        db[table].insert(game_data: data)
    end

    def drop_table
        sql = "DROP TABLE IF EXISTS #{table}"
        db.run sql
    end

    def retrieve_all_fields
        sql = "SELECT * from #{table} ORDER BY created_at DESC LIMIT 6"
        db.fetch sql
    end

    def retrieve_id_and_date
        sql = "SELECT id, created_at from #{table} ORDER BY created_at DESC LIMIT 6"
        db.fetch sql
    end


    def retrieve_game_data_by_id(id)
        db[table].where(id: id)
    end

    def create_table
        sql = "CREATE TABLE #{table} (
            id SERIAL PRIMARY KEY,
            game_data JSON,
            created_at TIMESTAMPTZ DEFAULT NOW()
        )"
        db.run sql
    end
end