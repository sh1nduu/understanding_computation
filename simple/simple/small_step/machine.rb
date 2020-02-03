# frozen_string_literal: true

module Simple
  class Machine
    attr_accessor :statement, :environment
    def initialize(statement, environment)
      @statement = statement
      @environment = environment
    end

    def step
      self.statement, self.environment = statement.reduce(environment)
    end

    def run
      step while statement.reducible?
      [statement, environment]
    end
  end
end
