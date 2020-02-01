# frozen_string_literal: true

require_relative './simple/small_step/reducible'
require_relative './simple/small_step/binary_operator'
require_relative './simple/small_step/variable'
require_relative './simple/small_step/assign'
require_relative './simple/small_step/if'
require_relative './simple/node'
require_relative './simple/small_step/do_nothing'
require_relative './simple/value'
require_relative './simple/binary_operator'
require_relative './simple/variable'
require_relative './simple/values'
require_relative './simple/operators'
require_relative './simple/assign'
require_relative './simple/if'
require_relative './simple/small_step/machine'

module Simple
  include SmallStep
end
