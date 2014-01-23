class Event < ActiveRecord::Base
  has_many :responses
  has_many :users, through: :responses

  belongs_to :creator, class_name: "User", foreign_key: :created_by

  scope :upcoming, -> { where("starts_at > ?", Time.current).order(starts_at: :asc) }

  def attending
    responses.count + responses.sum(:additional_guests)
  end

  def response_for(user)
    responses.where(user_id: user.id).first
  end

  def to_param
    "#{ id }-#{ name.parameterize }"
  end
end
