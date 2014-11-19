require 'test_helper'

class CoreExtensionsTest < MiniTest::Test
  def setup

  end

  def teardown

  end

  def test_integer
    value = 1
    weight = Weight.new("1.00")

    assert_equal weight, value.to_weight
  end

  def test_float
    value = 1.23
    weight = Weight.new("1.23")

    assert_equal weight, value.to_weight
  end

  def test_string
    value = "1.23"
    weight = Weight.new("1.23")

    assert_equal weight, value.to_weight
  end

  def test_big_decimal
    value = BigDecimal.new("1.23")
    weight = Weight.new("1.23")

    assert_equal weight, value.to_weight
  end
end
