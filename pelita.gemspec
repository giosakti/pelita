# encoding: utf-8
version = File.read(File.expand_path("../PELITA_VERSION", __FILE__)).strip

Gem::Specification.new do |spec|
  spec.name          = "pelita"
  spec.summary       = %q{No surprise, configurable glue microframework for building API in Ruby}
  spec.description   = %q{Pelita is a configurable glue microframework for building API in ruby that focus in simplicity and clarity whilst retaining rails convenience whenever possible}
  spec.license       = %q{MIT}
  spec.version       = version

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.authors       = ["Giovanni Sakti"]
  spec.email         = ["giosakti@gmail.com"]
  spec.homepage      = "http://github.com/giosakti/pelita"

  spec.required_ruby_version = '>= 2.3.0'

  spec.add_dependency "bcrypt", "~> 3.1"
  spec.add_dependency "dotenv", "~> 2.2"
  spec.add_dependency "dry-auto_inject", "~> 0.4"
  spec.add_dependency "dry-configurable", "~> 0.7"
  spec.add_dependency "dry-container", "~> 0.6"
  spec.add_dependency "dry-types", "~> 0.10"
  spec.add_dependency "dry-struct", "~> 0.3"
  spec.add_dependency "dry-system", "~> 0.7"
  spec.add_dependency "dry-validation", "~> 0.10"
  spec.add_dependency "dry-transaction", "~> 0.10"
  spec.add_dependency "graphql", "~> 1.6"
  spec.add_dependency "rack_csrf", "~> 2.6"
  spec.add_dependency "rack-protection", "~> 2.0"
  spec.add_dependency "rake", "~> 12.0"
  spec.add_dependency "roda", "~> 2.27"
  spec.add_dependency "rom", "~> 4.0.0"
  spec.add_dependency "rom-factory"
  spec.add_dependency "rom-sql", "~> 2.0.0"
  spec.add_dependency "warden", "~> 1.2"
  spec.add_dependency "thor", "~> 0.19.4"

  spec.add_development_dependency "database_cleaner", "~> 1.6"
  spec.add_development_dependency "rspec", "~> 3.6"
  spec.add_development_dependency "rubocop"
end
