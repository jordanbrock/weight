module WeightColumn
  module ActiveRecordHooks
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def weight_column(*columns)
        [columns].flatten.each do |name|
          define_method(name) do
            value = read_attribute(name)
            value.blank? ? nil : Weight.new(read_attribute(name))
          end

          define_method("#{name}_before_type_cast") do
            send(name) && sprintf("%.3f", send(name))
          end

          define_method("#{name}=") do |value|
            if value.blank? || !value.respond_to?(:to_weight)
              write_attribute(name, nil)
              nil
            else
              weight = value.to_weight
              write_attribute(name, weight.value)
              weight
            end
          end
        end
      end
    end
  end
end
