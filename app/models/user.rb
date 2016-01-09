class User < ActiveRecord::Base
  has_many :responses
  has_many :events, through: :responses
  has_many :created_events, class_name: "Event", foreign_key: :created_by
  has_many :identities

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

  def avatar(size: 512)
    Avatar.new(self, size: size)
  end

  def providers
    identities.pluck(:provider)
  end

  def provider?(provider_name)
    providers.include?(provider_name)
  end
end
