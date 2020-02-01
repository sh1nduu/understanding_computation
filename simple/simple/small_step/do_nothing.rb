# frozen_string_literal: true

module Simple
  module SmallStep
    class DoNothing < Simple::Node
      include Reducible

      def to_s
        'do-nothing'
      end

      def ==(other)
        other.instance_of?(self.class)
      end
    end
  end
end
