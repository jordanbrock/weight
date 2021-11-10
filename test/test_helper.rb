require "minitest"
require "minitest/autorun"
require "rails"
require "active_record"
require "weight"
require "weight_column"

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

load File.join(File.dirname(__FILE__), "schema.rb")

# Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
