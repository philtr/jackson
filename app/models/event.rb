class Event < ActiveRecord::Base
  has_many :responses
  has_many :users, through: :responses

  belongs_to :creator, class_name: "User", foreign_key: :created_by

  scope :upcoming, -> { where("events.starts_at > ?", Time.current).order("events.starts_at ASC") }
  scope :past, -> { where("events.starts_at < ?", Time.current).order("events.starts_at DESC") }

  def attending
    responses.count + responses.sum(:additional_guests)
  end

  def response_for(user)
    responses.where(user_id: user.id).first
  end

  def to_param
    "#{ id }-#{ name.parameterize }"
  end

  def self.user(user_or_id)
    user = User.find(user_or_id)

    Event
      .includes(:responses)
      .where("responses.user_id = ? OR events.created_by = ?", user.id, user.id)
      .references(:responses)
      .distinct.limit(10)
  end
end
