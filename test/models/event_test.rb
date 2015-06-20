require 'test_helper'

class EventTest < ActiveSupport::TestCase
  should have_many(:responses)
  should have_many(:users).through(:responses)
  should belong_to(:creator).class_name("User")

  context "The Event class" do
    should "list events starting in the future" do
      upcoming_event = create(:event, starts_at: 1.day.from_now)
      past_event = create(:event, starts_at: 1.day.ago)

      assert_equal true, Event.upcoming.include?(upcoming_event)
      assert_equal false, Event.upcoming.include?(past_event)
    end
  end

  context "An event" do
    setup do
      @event = create(:event, creator: create(:user))
    end

    should "have a head count" do
      create_list(:response, 2, event_id: @event.id, additional_guests: 3)
      assert_equal 8, @event.attending
    end

    should "find a response for a user" do
      user = create(:user)
      response = create(:response, event_id: @event.id, user_id: user.id)

      assert_equal response, @event.response_for(user)
    end

    should "parameterize all pretty like" do
      @event.name = "Happiness is a warm gun"
      assert_equal "#{ @event.id }-happiness-is-a-warm-gun", @event.to_param
    end

    should "resolve param back to integer" do
      assert_equal @event, Event.find(@event.to_param)
    end

    should "know if if it was created by a particular user" do
      assert_equal true, @event.created_by?(@event.creator)
    end
  end
end
