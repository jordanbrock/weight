require 'test_helper'

class WeightRecord < ActiveRecord::Base
  weight_column :ordered
end

class WeightColumnTest < MiniTest::Test
  def setup

  end

  def teardown

  end

  def test_typecast_string_to_grams
    m = WeightRecord.new(ordered: "100")

    assert_equal Weight.new(100), m.ordered
  end

  def test_typecast_numeric_to_grams
    m = WeightRecord.new(ordered: 1000)
    assert_equal Weight.new(1000), m.ordered
  end

  def test_typecast_blank_to_nil
    m = WeightRecord.new(ordered: "")
    assert_equal m.ordered, nil
  end

  def test_typecase_invalid_string_to_empty
    m = WeightRecord.new(ordered: "chicken")
    assert_equal Weight.new(0), m.ordered
  end

  def test_typecast_invalid_value_to_nil
    m = WeightRecord.new(ordered: true)
    assert_equal nil, m.ordered
  end
end
