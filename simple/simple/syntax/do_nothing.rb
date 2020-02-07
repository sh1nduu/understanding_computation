# frozen_string_literal: true

module Simple
  class DoNothing < Simple::Node
    def to_s
      'do-nothing'
    end

    def ==(other)
      other.instance_of?(self.class)
    end
  end
end
