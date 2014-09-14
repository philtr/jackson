require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:responses)
  should have_many(:events).through(:responses)
  should have_many(:created_events).class_name("Event")

  context "A user" do
    setup do
      @user = create(:user)
    end

    should "know if they are attending a specific event or not" do
      assert_equal false, @user.attending?(create(:event))
    end

    should "get and set first and last name from full_name field" do
      @user.full_name = "James Earl Jones"
      assert_equal "James Earl Jones", @user.full_name
      assert_equal "James", @user.first_name
      assert_equal "Earl Jones", @user.last_name
    end

    should "have a list of the providers of their current identities" do
      create_list(:identity, 2, user: @user)
      assert_equal [ "factory_girl_1", "factory_girl_2" ], @user.providers
    end

    should "know whether or not they have an identity with a particular provider" do
      @user.stubs(:providers).returns(["test1","test2","test3"])
      assert_equal true, @user.provider?("test2")
    end

    should "have a gravatar" do
      assert_match(/^http:\/\/www.gravatar.com/i, @user.gravatar)
    end

    context "without an email address" do
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

      should "have a random avatar generator" do
        avatar_url = @user.send(:random_avatar)
        assert_match(/https?:\/\/.*/, avatar_url)
      end
    end
  end
end
