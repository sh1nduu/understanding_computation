# frozen_string_literal: true

module Node
  def inspect
    "#{self.class.name}(#{self})"
  end
end
