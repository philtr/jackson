class User < ActiveRecord::Base
  has_many :responses
  has_many :events, through: :responses
  has_many :created_events, class_name: "Event", foreign_key: :created_by

  def self.authorize(auth)
    User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.first_name ||= auth.info.first_name.presence  || auth.info.name.split(' ').first
      user.last_name  ||= auth.info.last_name.presence   || auth.info.name.split(' ').last
      user.email      ||= auth.info.email

      user.token      ||= auth.credentials.token

      user.auth_hash    = auth.to_h
    end
  end
end
