ENV["RAILS_ENV"] ||= "test"
require 'simplecov'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'factory_girl'
require 'mocha/setup'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  fixtures :all

  include FactoryGirl::Syntax::Methods
end
