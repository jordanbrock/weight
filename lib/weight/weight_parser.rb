class WeightParser
  ZERO_WEIGHT = "0.000"

  def self.parse(input)
    new.parse(input)
  end

  def parse(input)
    Weight.new(extract_weight(input))
  end

  private

  def extract_weight(input)
    return ZERO_WEIGHT if input.to_s.empty?

    amount = input.scan(/-?[\d.,]+/).first

    return ZERO_WEIGHT if amount.nil?

    amount.gsub!(/^(-)?(0[,.]\d\d)\d+$/, '\1\2')

    segments = amount.scan(/^(.*?)(?:[.,](\d{1,3}))?$/).first

    return ZERO_WEIGHT if segments.empty?

    amount = segments[0].gsub(/[^-\d]/, "")
    decimals = segments[1].to_s.ljust(3, "0")

    "#{amount}.#{decimals}"
  end
end
