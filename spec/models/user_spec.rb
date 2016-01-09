require "rails_helper"

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
      assert_equal ["factory_girl_1", "factory_girl_2"], user.providers
    end

    it "has knowledge of identities with a particular provider" do
      allow(user).to receive(:providers).and_return(["test1", "test2", "test3"])
      assert_equal true, user.provider?("test2")
    end

    it "has an avatar" do
      expect(user.avatar).to be_an(Avatar)
    end
  end
end
