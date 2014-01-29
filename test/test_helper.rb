ENV["RAILS_ENV"] ||= "test"

if ENV["TRAVIS"]
  require 'coveralls'
  Coveralls.wear!('rails')
end

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'factory_girl'
require 'mocha/setup'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  include FactoryGirl::Syntax::Methods

  fixtures :all
end
