require 'rails_helper'

describe User do
  it { should have_many(:responses) }
  it { should have_many(:events).through(:responses) }
  it { should have_many(:created_events).class_name("Event") }

  context "A user" do
    let(:user) { create(:user) }

    it "knows if they are attending a specific event or not" do
      assert_equal false, user.attending?(create(:event))
    end

    it "gets and sets first and last name from full_name field" do
      user.full_name = "James Earl Jones"
      assert_equal "James Earl Jones", user.full_name
      assert_equal "James", user.first_name
      assert_equal "Earl Jones", user.last_name
    end

    it "has a list of the providers of their current identities" do
      create_list(:identity, 2, user: user)
      assert_equal [ "factory_girl_1", "factory_girl_2" ], user.providers
    end

    it "knows whether or not they have an identity with a particular provider" do
      allow(user).to receive(:providers).and_return(["test1","test2","test3"])
      assert_equal true, user.provider?("test2")
    end

    it "has a gravatar" do
      assert_match(/^http:\/\/www.gravatar.com/i, user.gravatar)
    end

    context "without an email address" do
      it "uses a specified avatar if present" do
        user.email = nil
        user.avatar_url = "http://google.com"

        assert_equal "http://google.com", user.gravatar
      end

      it "uses a random avatar if none specified" do
        allow_any_instance_of(User).to receive(:random_avatar).and_return(nil)
        user.email = nil
        user.avatar_url = nil

        user.gravatar
      end

      it "has a random avatar generator" do
        avatar_url = user.send(:random_avatar)
        assert_match(/https?:\/\/.*/, avatar_url)
      end
    end
  end
end
