require 'test_helper'

class Xi::OSCTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Xi::OSC::VERSION
  end
end
