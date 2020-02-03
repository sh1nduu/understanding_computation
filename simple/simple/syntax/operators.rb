# frozen_string_literal: true

module Simple
  class Add < BinaryOperator
    use_symbol :+
    reduce_to Number
  end

  class Multiply < BinaryOperator
    use_symbol :*
    reduce_to Number
  end

  class LessThan < BinaryOperator
    use_symbol :<
    reduce_to Boolean
  end
end
