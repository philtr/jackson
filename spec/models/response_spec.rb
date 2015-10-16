require "rails_helper"

describe Response do
  it { should belong_to(:event) }
  it { should belong_to(:user) }

  context "The Response class" do
    it "lists responses for upcoming events" do
      upcoming_event    = create(:event, starts_at: 1.day.from_now)
      upcoming_response = create(:response, event_id: upcoming_event.id)
      past_event        = create(:event, starts_at: 1.day.ago)
      past_response     = create(:response, event_id: past_event.id)

      assert_equal true, Response.upcoming.include?(upcoming_response)
      assert_equal false, Response.upcoming.include?(past_response)
    end
  end

  context "A response" do
    it "sets additional guests to 0 if a negative number is provided" do
      response = build(:response, additional_guests: -95)
      response.valid?

      assert_equal 0, response.additional_guests
    end
  end
end
