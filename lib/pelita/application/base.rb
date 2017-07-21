# frozen_string_literal: true

require 'erb'
require_relative '../util/db'

module Pelita
  module Application
    class Base < Roda
      extend Dry::Configurable
      extend Pelita::Util::Db

      # Setup routing tree
      plugin :multi_run
      plugin :indifferent_params

      def self.root_path
        File.expand_path('')
      end

      def self.env
        ENV['PELITA_ENV'] || 'development'
      end

      # Load or set initial configurations
      setting :root, Base.root_path
      setting :env, Base.env
    end
  end
end
