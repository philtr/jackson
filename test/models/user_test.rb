require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:responses)
  should have_many(:events).through(:responses)
  should have_many(:created_events).class_name("Event")

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

  context "A user" do
    setup do
      @user = create(:user)
    end

    should "know if they are attending a specific event or not" do
      assert_equal false, @user.attending?(create(:event))
    end

    should "have a gravatar" do
      assert_match(/^http:\/\/www.gravatar.com/i, @user.gravatar)
    end

    context "A user without an email address" do
      should "use a specified avatar if present" do
        @user.email = nil
        @user.avatar_url = "http://google.com"

        assert_equal "http://google.com", @user.gravatar
      end

      should "use a random avatar if none specified" do
        User.any_instance.expects(:random_avatar)
        @user.email = nil
        @user.avatar_url = nil

        @user.gravatar

        User.any_instance.unstub(:random_avatar)
      end
    end
  end
end
