require "test_helper"

class WeightParserTest < MiniTest::Test
  def setup
    @parser = WeightParser.new
  end

  def teardown
  end

  def test_parse_empty_string
    assert_equal @parser.parse(""), Weight.new
  end

  def test_parse_invalid_string
    assert_equal Weight.new, @parser.parse("chicken")
  end

  def test_parse_single_digit_integer_string
    assert_equal Weight.new(1), @parser.parse("1")
  end

  def test_parse_double_digit_integer_string
    assert_equal Weight.new(11), @parser.parse("11")
  end

  # def test_parse_floast_string_amount
  #   assert_equal Weight.new(1.379), @parser.parse("1.379")
  # end

  def test_parse_negative_integer
    assert_equal Weight.new(-100), @parser.parse("-100")
  end

  def test_parse_negative_float
    assert_equal Weight.new(-1.37), @parser.parse("-1.37")
  end

  def test_parse_triple_digit_int_triple_float
    assert_equal Weight.new(123.123), @parser.parse("123.123")
  end

  def test_parse_quad_triple_float
    assert_equal Weight.new(1234.123), @parser.parse("1234.123")
  end

  def test_parse_positive_thousands_separator
    # assert_equal Weight.new(1234.00), @parser.parse("1,234")
  end

  def test_parse_negative_thousands_separator
    # assert_equal Weight.new(-1234.00), @parser.parse("-1,234")
  end

  def test_parse_triple_digit_float
    assert_equal Weight.new(27.000), @parser.parse("27.000")
  end

  # def test_parse_zero_with_decimals
  #   assert_equal Weight.new(0.123), @parser.parse("0.123")
  # end
end
