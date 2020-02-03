# frozen_string_literal: true

module Simple
  module Reducible
    def self.included(klass)
      klass.extend ClassMethods
    end

    def reducible?
      !reduced_class.nil?
    end

    def reduce
      raise NotImplementedError
    end

    def reduced_class
      self.class.reduced_class
    end

    module ClassMethods
      attr_accessor :reduced_class
      def reduce_to(klass)
        self.reduced_class = klass
      end
    end
  end
end
