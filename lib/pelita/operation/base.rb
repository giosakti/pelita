require_relative 'attempt_adapter'

module Pelita
  module Operation
    class Base
      include Dry::Transaction

      def authorize!(options)
        if options["current_user"].signed_in?
          options["result.policy.default"] = true
          Right(options)
        else
          options["result.policy.default"] = false
          Left(options)
        end
      end
    end
  end
end
