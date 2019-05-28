require 'sequel'

class Local
    attr_accessor :db, :table

    def initialize(table_name = :tic_tac_toe)
        @db = Sequel.connect(adapter: 'postgres', host: 'localhost', database: 'tic_tac_toe', user: 'postgres', password: 'postgres')
        @table = table_name.to_sym
        clean_table if table_name == :test
        create_table if !table_exists?
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
            SuspendedGame.new(game_log.fetch(:id), game_log.fetch(:created_at))
        end
    end

    def disconnect
        db.disconnect
    end

    private
    SuspendedGame = Struct.new(:id, :created_at)

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

    def table_exists?
        db.table_exists?(table)
    end
end