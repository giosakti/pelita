module Pelita
  module Util
    module Db
      def fetch_db_config(file)
        db_config = File.read(file)
        db_config = ERB.new(db_config).result
        db_config = YAML.safe_load(db_config)

        db_config
      end
      module_function :fetch_db_config
      public :fetch_db_config

      def generate_connection_string(db_config)
        conn_string = db_config['adapter']

        unless db_config['host'].blank?
          host_string = db_config['host']
          host_string = "#{host_string}:#{db_config["port"]}" unless db_config['port'].blank?

          unless db_config['username'].blank?
            user_string = db_config['username']
            user_string = "#{user_string}:#{db_config["password"]}" unless db_config['password'].blank?
            host_string = "#{user_string}@#{host_string}"
          end

          conn_string = "#{conn_string}://#{host_string}"
          conn_string = "#{conn_string}/#{db_config["database"]}" unless db_config['database'].blank?
        end

        conn_string
      end
      module_function :generate_connection_string
      public :generate_connection_string
    end
  end
end
