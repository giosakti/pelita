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
  end
end
