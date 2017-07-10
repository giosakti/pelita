# frozen_string_literal: true

require 'erb'

module Pelita
  module Application
    class Base < Roda
      extend Dry::Configurable

      # Setup routing tree
      plugin :multi_run
      route(&:multi_run)

      def self.root_path
        File.expand_path('')
      end

      def self.env
        ENV['PELITA_ENV'] || 'development'
      end

      def self.fetch_db_config(file)
        db_config = File.read(file)
        db_config = ERB.new(db_config).result
        db_config = YAML.safe_load(db_config)

        db_config
      end

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

      # Load or set initial configurations
      setting :root, Base.root_path
      setting :env, Base.env
      setting :db do
        setting :config, Base.fetch_db_config("#{Base.root_path}/config/database.yml")[Base.env]
      end
    end
  end
end
