# frozen_string_literal: true

module Simple
  class Add < BinaryOp
    use_symbol :+
    reduce_to Number
  end

  class Multiply < BinaryOp
    use_symbol :*
    reduce_to Number
  end

  class LessThan < BinaryOp
    use_symbol :<
    reduce_to Boolean
  end
end
