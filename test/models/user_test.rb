require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context "The User class" do
    should "authorize from an auth object" do
      auth = Auth.new({ provider:    'user_test',
                        uid:         '1234',
                        info:        { name:   'Test User', email:  'testuser@h4q.me' },
                        credentials: { token: '1234567890' } })

      @user = User.authorize(auth)

      assert_equal true, @user.valid?
    end
  end
end
