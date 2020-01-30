module Reducible
  def self.included(klass)
    klass.extend ClassMethods
  end

  def reducible?
    self.class._reducible
  end

  def reduce
    raise NotImplementedError unless reducible?
  end

  module ClassMethods
    attr_accessor :_reducible
    def reducible(bool)
      self._reducible = bool
    end
  end
end