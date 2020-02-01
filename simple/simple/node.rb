# frozen_string_literal: true

module Simple
  class Node
    def inspect
      "#{self.class.name}(#{self})"
    end

    def ==(other)
      self.class == other.class
    end
  end
end
