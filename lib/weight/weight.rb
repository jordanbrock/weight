require 'bigdecimal'
require 'bigdecimal/util'

class Weight
  include Comparable

  attr_reader :value, :grams

  def initialize(value = 0)
    raise ArgumentError if value.respond_to?(:nan?) && value.nan?

    @value = value_to_decimal(value).round(3)
    @grams = (@value * 1000).to_i
  end

  def -@
    Weight.new(-value)
  end

  def <=>(other)
    grams <=> other.to_weight.grams
  end

  def +(other)
    Weight.new(value + other.to_weight.value)
  end

  def -(other)
    Weight.new(value - other.to_weight.value)
  end

  def *(numeric)
    Weight.new(value * numeric)
  end

  def /(numeric)
    raise "[Weight] Dividing weight objects can lose grams. Use #split instead"
  end

  def inspect
    "#<#{self.class} value:#{self.to_s}>"
  end

  def ==(other)
    eql?(other)
  end

  def eql?(other)
    self.class == other.class && value == other.value
  end

  class ReverseOperationProxy
    def initialize(value)
      @value = value
    end

    def <=>(other)
      -(other <=> @value)
    end

    def +(other)
      other + @value
    end

    def -(other)
      -(other - @value)
    end

    def *(other)
      other * @value
    end
  end

  def coerce(other)
    raise TypeError, "Weight can't be coerced into #{other.class}" unless other.is_a?(Numeric)
    [ReverseOperationProxy.new(other), self]
  end

  def hash
    value.hash
  end

  def self.parse(input)
    parser.parse(input)
  end

  def self.parser
    @@parser ||= WeightParser
  end

  def self.parser=(new_parser_class)
    @@parser = new_parser_class
  end

  def self.empty
    Weight.new
  end

  def self.from_grams(grams)
    Weight.new(grams.round.to_f / 1000)
  end

  def to_weight
    self
  end

  def zero?
    value.zero?
  end

  def to_i
    value.to_i
  end

  def to_f
    value.to_f
  end

  def to_s
    sprintf("%.3f", value.to_f)
  end

  def to_json(options={})
    to_s
  end
  
  def as_json(*args)
    to_s
  end

  def floor
    Weight.new(value.floor)
  end

  def abs
    Weight.new(value.abs)
  end

  def round(*args)
    Weight.new(value.round(*args))
  end

  def fraction(rate)
    raise ArgumentError, "rate should be positive" if rate < 0

    result = value / (1 + rate)
    Weight.new(result)
  end

  def split(num)
    raise ArgumentError, "need at least one party" if num < 1
    low = Weight.from_grams(grams / num)
    high = Weight.from_grams(low.grams + 1)

    remainder = grams % num
    result = []

    num.times do |index|
      result[index] = index < remainder ? high : low
    end

    return result
  end

  def allocate(splits)
    allocations = splits.inject(0.0) {|sum, i| sum += i }
    raise ArgumentError, "splits add to more than 100%" if allocations > 1.0

    left_over = grams

    amounts = splits.collect do |ratio|
      fraction = (grams * ratio / allocations).floor
      left_over -= fraction
      fraction
    end

    left_over.times { |i| amounts[i % amounts.length] += 1 }

    return amounts.collect { |grams| Weight.from_grams(grams) }
  end


  private
  def value_to_decimal(value)
    if value.class == BigDecimal
      value
    elsif value.respond_to?(:to_d)
      value.to_d
    else
      value.to_s.to_d
    end
  end
end
