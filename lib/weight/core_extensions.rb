class Numeric
  def to_weight
    Weight.new(self)
  end
end

class String
  def to_weight
    empty? ? Weight.empty : Weight.parse(self)
  end
end
