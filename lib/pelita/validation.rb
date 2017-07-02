module Pelita
  module Validation
    def self.Schema(base = Dry::Validation::Schema, **options, &block)
      Dry::Validation.Schema(base, options, &block)
    end
  end
end
