class Response < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  scope :upcoming, -> { joins(:event).where("events.starts_at > ?", Time.current) }
end
