require 'test_helper'

class WeightTest < MiniTest::Test
  def setup
    @weight = Weight.new
  end

  def teardown

  end

  def test_parser
    assert_equal 0.123, Weight.new("0.123").to_f
  end

  def test_return_self_as_weight
    assert_equal @weight, @weight.to_weight
  end

  def test_default_to_0
    assert_equal 0.000, @weight.value
  end

  def test_default_to_0_with_no_arguments
    assert_equal Weight.new(0.000), @weight
  end

  def test_to_s_should_return_two_decimals
    assert_equal "0.000", @weight.to_s
  end

  def test_construct_with_fixnum
    assert_equal Weight.new(3.00), Weight.new(3)
  end

  def test_construct_with_float
    assert_equal Weight.new(3.00), Weight.new(3.00)
  end

  def test_addable
    assert_equal Weight.new(5.00), (Weight.new(2.499) + Weight.new(2.501))
  end

  def test_subtractable
    assert_equal Weight.new(3.501), (Weight.new(5.000) - Weight.new(1.499))
  end

  def test_subtractable_to_zero
    assert_equal Weight.new(0.00), (Weight.new(5.00) - Weight.new(5.00))
  end

  def test_subtractable_to_negative
    assert_equal Weight.new(-2.00), (Weight.new(5.00) - Weight.new(7.00))
  end

  def test_inspect
    assert_equal "#<Weight value:0.000>", @weight.inspect
  end

  def test_within_inspect
    assert_equal "[#<Weight value:0.000>]", [@weight].inspect
  end

  def test_eql?
    assert @weight.eql?(Weight.new)
  end

  def test_addable_with_integer
    assert_equal Weight.new(4.33), (Weight.new(3.33) + 1)
  end

  def test_addable_with_float
    assert_equal Weight.new(4.35), (Weight.new(3.33) + 1.02)
  end

  def test_subtractable_with_integer
    assert_equal Weight.new(3.33), (Weight.new(4.33) - 1)
  end

  def test_subtractable_with_float
    assert_equal Weight.new(3.33), (Weight.new(4.35) - 1.02)
  end

  def test_multiplicable_by_integer
    assert_equal Weight.new(12.00), (Weight.new(1.00) * 12)
  end
  
  def test_multiplicable_by_float
    assert_equal Weight.new(7.50), (Weight.new(5.00) * 1.5)
  end

  def test_multiplicable_by_repeating_float
    assert_equal Weight.new(0.800), (Weight.new(24.000) * (1 / 30.0))
  end
  
  def test_return_grams_as_json
    assert_equal "1.000", Weight.new(1.00).to_json
  end

  def test_support_to_f
    assert_equal "1.5", Weight.new(1.50).to_f.to_s
  end

  def test_create_from_grams_amount
    assert_equal Weight.new(1.950), Weight.from_grams(1950)
  end

  def test_create_from_float_grams_amount
    assert_equal Weight.new(1.951), Weight.from_grams(1950.5)
  end

  def test_comparable_with_non_weight_objects
    refute @weight == nil
  end

  def test_allocate_does_nothing_split_one_way
    assert_equal [Weight.new(5)], Weight.new(5).allocate([1])
  end

  def test_allocation_does_not_lose_grams
    weights = Weight.new(0.05).allocate([0.3,0.7])
    assert_equal Weight.new(0.015), weights[0]
    assert_equal Weight.new(0.035), weights[1]
  end

  def test_split_gives_1_to_each_split
    assert_equal [Weight.new(1), Weight.new(1)], Weight.new(2).split(2)
  end

  def test_split_a_kilo
    weights = Weight.new(1).split(3)

    assert_equal weights[0], Weight.new(0.334)
    assert_equal weights[1], Weight.new(0.333)
    assert_equal weights[2], Weight.new(0.333)
  end
end
