module Pelita
  module Auth
    module Helpers
      def warden
        request.env['warden']
      end

      def session(scope)
        warden.session(scope)
      end

      def authenticated?(scope = nil)
        scope ? warden.authenticated?(scope: scope) : warden.authenticated?
      end
      alias_method :logged_in?, :authenticated?

      def authenticate(*args)
        warden.authenticate!(*args)
      end
      alias_method :login, :authenticate

      def logout(scope = nil)
        scope ? warden.logout(scope) : warden.logout(warden.config.default_scope)
      end
    end
  end
end
