require 'rom/sql/rake_task'
require 'pelita'
require 'sequel'

namespace :db do
  # Setup connection string
  pelita = ::Pelita::Application::Base
  db_config = pelita.
    fetch_db_config("#{pelita.config.root}/config/database.yml")[pelita.config.env]
  conn_string = pelita.generate_connection_string(db_config)

  task :setup do
    ::Pelita::Persistence.container(:sql, conn_string) do |conf|
      # NOP
    end
  end

  # TODO: @giosakti make this database agnostic
  desc 'Create database'
  task :create do
    DB = Sequel.send(
      db_config['adapter'].to_sym,
      'postgres',
      user: db_config['username'],
      password: db_config['password'],
      host: db_config['host'],
      port: db_config['port']
    )

    begin
      puts "execute db:create"
      DB.run("CREATE DATABASE #{db_config["database"]} OWNER #{db_config["username"]}")
    rescue Sequel::DatabaseError
      puts "Database #{db_config["database"]} already exists"
    end

    DB.disconnect

    Rake::Task['db:setup'].invoke
  end

  # TODO: @giosakti make this database agnostic
  desc 'Destroy database'
  task :drop do
    DB = Sequel.send(
      db_config['adapter'].to_sym,
      'postgres',
      user: db_config['username'],
      password: db_config['password'],
      host: db_config['host'],
      port: db_config['port']
    )

    begin
      puts 'execute db:drop'
      DB.run("DROP DATABASE #{db_config["database"]}")
    rescue Sequel::DatabaseError
      puts "Database #{db_config["database"]} didn't exists or already dropped"
    end

    DB.disconnect
  end

  desc 'Dump database schema into a file'
  task :dump_schema do
    DB = Sequel.send(
      db_config['adapter'].to_sym,
      'postgres',
      user: db_config['username'],
      password: db_config['password'],
      host: db_config['host'],
      port: db_config['port']
    )

    `sequel -D #{"postgres"}://#{db_config['host']}/#{db_config['database']} > #{pelita.config.root}/db/schema.rb`
    puts "Schema migration was created in #{pelita.config.root}/db/schema.rb"

    DB.disconnect
  end

  desc 'Seed database'
  task :seed do
    load File.join pelita.config.root, 'db', 'seeds.rb'
    puts 'Seeds was successfully executed'
  end
end
