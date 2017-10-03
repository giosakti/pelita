require_relative 'attempt_adapter'

module Pelita
  module Operation
    class Base
      include Dry::Transaction

      def authorize!(options)
        if options['current_user'].present?
          options['result.policy.default'] = true
          Right(options)
        else
          options['result.policy.default'] = false
          options['result.policy.errors'] = "You're not authorized."
          Left(options)
        end
      end
    end
  end
end
