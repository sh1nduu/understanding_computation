# frozen_string_literal: true

module Simple
  class If
    include Reducible
    reduce_to [].class

    def reduce(environment)
      if condition.reducible?
        [reduced_if(environment), environment]
      elsif condition == Boolean.new(true)
        [consequence, environment]
      elsif condition == Boolean.new(false)
        [alternative, environment]
      end
    end

    private
    def reduced_if(environment)
      self.class.new(
        condition.reduce(environment), consequence, alternative
      )
    end
  end
end
