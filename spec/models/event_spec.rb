require "rails_helper"

describe Event do
  it { should have_many(:responses) }
  it { should have_many(:users).through(:responses) }
  it { should belong_to(:creator).class_name("User") }

  context "The Event class" do
    it "lists events starting in the future" do
      upcoming_event = create(:event, starts_at: 1.day.from_now)
      past_event = create(:event, starts_at: 1.day.ago)

      assert_equal true, Event.upcoming.include?(upcoming_event)
      assert_equal false, Event.upcoming.include?(past_event)
    end
  end

  context "An event" do
    let(:event) { create(:event, creator: create(:user)) }

    it "has a head count" do
      create_list(:response, 2, event_id: event.id, additional_guests: 3)
      assert_equal 8, event.attending
    end

    it "finds a response for a user" do
      user = create(:user)
      response = create(:response, event_id: event.id, user_id: user.id)

      assert_equal response, event.response_for(user)
    end

    it "parameterizes all pretty like" do
      event.name = "Happiness is a warm gun"
      assert_equal "#{event.id}-happiness-is-a-warm-gun", event.to_param
    end

    it "resolves param back to integer" do
      assert_equal event, Event.find(event.to_param)
    end

    it "knows if if it was created by a particular user" do
      assert_equal true, event.created_by?(event.creator)
    end
  end
end
