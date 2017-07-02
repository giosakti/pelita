require 'rom'

module Pelita
  module Persistence
    def self.container(*args, &block)
      ROM.container(*args, &block)
    end
  end
end
