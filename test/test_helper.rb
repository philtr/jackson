ENV["RAILS_ENV"] ||= "test"

require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start('rails') do
  add_group "Services", "app/services"
end

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'factory_girl'
require 'mocha/setup'

Minitest::Reporters.use! [ Minitest::Reporters::DefaultReporter.new ]

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  include FactoryGirl::Syntax::Methods

  fixtures :all
end

class ActionController::TestCase
  def signin_as(user)
    @controller.send(:sign_in_as, user)
  end
end
