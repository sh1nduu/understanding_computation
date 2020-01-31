# frozen_string_literal: true

class Node
  def inspect
    "#{self.class.name}(#{self})"
  end
end
