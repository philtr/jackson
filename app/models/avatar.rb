class Avatar
  attr_reader :size
  attr_reader :user

  def initialize(user, size: 512)
    @user = user
    @size = size
  end

  def gravatar(style: :retro)
    "https://www.gravatar.com/avatar/#{email_digest}?s=#{size}&d=#{style}"
  end

  def url
    gravatar
  end

  def to_s
    url
  end

  private

  def email_digest
    Digest::MD5.hexdigest(user.email.to_s.downcase)
  end
end
