require "test_helper"

class ResponseTest < ActiveSupport::TestCase
  should belong_to(:event)
  should belong_to(:user)

  context "The Response class" do
    should "list responses for upcoming events" do
      upcoming_event    = create(:event, starts_at: 1.day.from_now)
      upcoming_response = create(:response, event_id: upcoming_event.id)
      past_event        = create(:event, starts_at: 1.day.ago)
      past_response     = create(:response, event_id: past_event.id)

      assert_equal true, Response.upcoming.include?(upcoming_response)
      assert_equal false, Response.upcoming.include?(past_response)
    end
  end
end
