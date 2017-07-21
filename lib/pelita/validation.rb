module Pelita
  module Validation
    def self.Schema(base = Dry::Validation::Schema, **options, &block)
      Dry::Validation.Schema(base, options, &block)
    end

    def self.Form(&block)
      Dry::Validation.Form(&block)
    end
  end
end
