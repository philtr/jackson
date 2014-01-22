class Event < ActiveRecord::Base
  has_many :responses
  has_many :users, through: :responses

  belongs_to :creator, class_name: "User", foreign_key: :created_by

  scope :upcoming, -> { where("starts_at > ?", Time.current).order(starts_at: :asc) }


  def to_param
    "#{ id }-#{ name.parameterize }"
  end
end
