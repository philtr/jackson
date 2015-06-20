class Response < ActiveRecord::Base
  belongs_to :event, touch: true
  belongs_to :user

  scope :upcoming, -> { joins(:event).where("events.starts_at > ?", Time.current) }
  scope :today, -> { joins(:event).where("events.starts_at > ? AND events.starts_at < ?", Time.current.beginning_of_day, Time.current.end_of_day) }

  before_validation :ensure_positive_integer_for_additional_guests

  private

  def ensure_positive_integer_for_additional_guests
    if additional_guests < 0
      self.additional_guests = 0
    end
  end
end
