module Pelita
  module SQL
    def self.migration(*args, &block)
      ROM::SQL.migration(*args, &block)
    end
  end
end
