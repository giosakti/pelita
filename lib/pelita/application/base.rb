# frozen_string_literal: true

require 'erb'

module Pelita
  module Application
    class Base < Roda
      extend Dry::Configurable

      # Load or set initial configurations
      setting :root, File.expand_path('')
      setting :env, ENV['PELITA_ENV'] || 'development'

      # Setup routing tree
      plugin :multi_run
      route(&:multi_run)

      def self.generate_connection_string(db_config)
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

      def self.db_config
        # Load db configuration
        db_config = File.read("#{config.root}/config/database.yml")
        db_config = ERB.new(db_config).result
        db_config = YAML.safe_load(db_config)

        # Setup connection string
        db_config[config.env]
      end
    end
  end
end
