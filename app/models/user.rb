class User < ActiveRecord::Base
  has_many :responses
  has_many :events, through: :responses
  has_many :created_events, class_name: "Event", foreign_key: :created_by

  def attending?(event)
    events.include?(event)
  end

  def full_name
    [ first_name, last_name ].compact.join(" ").presence
  end

  def full_name=(new_name)
    names = new_name.to_s.split(" ")
    self.first_name = names.shift
    self.last_name = names.join(" ")
  end

  def gravatar(size = 500)
    "http://www.gravatar.com/avatar/#{ Digest::MD5.hexdigest(email.downcase) }?s=#{ size }&d=retro"
  rescue
    avatar_url.presence || random_avatar
  end

  def assign_nil_attributes(attrs)
    old_attributes = attributes.reject { |key, value| value.blank? }
    new_attributes = attrs.reject { |key, value| value.blank? }

    assign_attributes(new_attributes.merge(old_attributes))

    self
  end

  def self.authorize(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first_or_initialize

    user.assign_nil_attributes({
      full_name:  auth.info.name,
      first_name: auth.info.first_name,
      last_name:  auth.info.last_name,
      email:      auth.info.email,
      avatar_url: auth.info.image,
      token:      auth.credentials.token,
      auth_hash:  auth.to_h
    })

    user.tap(&:save)
  end

  protected

  def random_avatar(size = 500)
    [
      "http://placekitten.com/#{ size }/#{ size }",
      "http://www.avatarpro.biz/avatar?s=#{ size }",
      "http://placedog.com/#{ size }/#{ size }",
      "http://lorempixel.com/#{ size }/#{ size }",
    ].sample
  end

end
