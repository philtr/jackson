class Response < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  scope :upcoming, -> { joins(:event).where("events.starts_at > ?", Time.current) }
  scope :today, -> { joins(:event).where("events.starts_at > ? AND events.starts_at < ?", Time.current.beginning_of_day, Time.current.end_of_day) }
end
