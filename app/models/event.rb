class Event < ActiveRecord::Base
  include FriendlyDatetime

  friendly_datetime :starts_at, :ends_at

  has_many :responses
  has_many :users, through: :responses

  belongs_to :creator, class_name: "User", foreign_key: :created_by

  scope :upcoming, -> { where("events.starts_at > ?", Time.current).order("events.starts_at ASC") }
  scope :past, -> { where("events.starts_at < ?", Time.current).order("events.starts_at DESC") }


  def attending
    responses.count + responses.sum(:additional_guests)
  end

  def created_by?(user)
    created_by == user.id rescue false
  end

  def response_for(user)
    responses.where(user_id: user.id).first
  end

  def to_param
    "#{ id }-#{ name.parameterize }"
  end
end
