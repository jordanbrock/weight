module WeightColumn
  class Railtie < Rails::Railtie
    ActiveSupport.on_load :active_record do
      ActiveRecord::Base.send(:include, WeightColumn::ActiveRecordHooks)
    end
  end
end
