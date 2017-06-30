module Pelita
  class Application < Roda
    extend Dry::Configurable

    # Load or set initial configurations
    setting :root, File.expand_path('')
    setting :env, ENV['PELITA_ENV'] || 'development'

    # Setup routing tree
    plugin :multi_run
    route do |r|
      r.multi_run
    end

    def self.generate_connection_string(db_config)
      conn_string = db_config['adapter']

      unless db_config['host'].blank?
        host_string = db_config['host']
        host_string = "#{host_string}:#{db_config['port']}" unless db_config['port'].blank?

        unless db_config['username'].blank?
          user_string = db_config['username']
          user_string = "#{user_string}:#{db_config['password']}" unless db_config['password'].blank?
          host_string = "#{user_string}@#{host_string}"
        end

        conn_string = "#{conn_string}://#{host_string}"
        conn_string = "#{conn_string}/#{db_config['database']}" unless db_config['database'].blank?
      end

      return conn_string
    end
  end
end
