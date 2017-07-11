module Pelita
  module Presenter
    class Base
      def initialize(object, opts = {})
        @object = object
        @notifications = (opts[:notifications] || [])
        @opts = opts
      end

      def as_hash
        hsh = self.wrapper if self.respond_to? :wrapper
        hsh = {}
        self.serialized_attributes.each do |serialized_attribute|
          hsh.merge!(serialized_attribute => self.send(serialized_attribute))
        end

        hsh
      end

      def as_json(*)
        self.as_hash.to_json
      end
    end
  end
end
