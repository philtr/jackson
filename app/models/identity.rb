class Identity < ActiveRecord::Base
  belongs_to :user

  before_save :assign_user
  after_save :merge_cleanup

  def assign_empty_attributes(attrs)
    old_attributes = HashCompactor.call(attributes)
    new_attributes = HashCompactor.call(attrs)

    assign_attributes(new_attributes.merge(old_attributes))

    self
  end

  def assign_user
    if user_id.blank?
      create_user(full_name: full_name, email: email)
    end
  end

  def destroy_merged_user
    orphaned_user.destroy if orphaned_user.present?
  end

  def destroy_duplicate_responses
    user.responses.group_by(&:event_id).each do |event_id, responses|
      if responses.count > 1
        responses.first.additional_guests ||= responses.last.additional_guests
        responses.first.comments ||= responses.last.comments
        responses.last.destroy
      end
    end
  end

  def full_name
    [ first_name, last_name ].compact.join(" ").presence
  end

  def full_name=(new_name)
    names = new_name.to_s.split(" ")
    self.first_name = names.shift
    self.last_name = names.join(" ")
  end

  def merge_cleanup
    destroy_merged_user
    destroy_duplicate_responses
  end

  def merge_users(new_user)
    return user unless new_user.present?
    self.user = new_user and return if user.nil?

    unless new_user.id == user_id
      new_attributes = HashCompactor.call(new_user.attributes).except("id")
      old_attributes = HashCompactor.call(user.attributes).except("id")

      new_user.assign_attributes(new_attributes.merge(old_attributes))

      user.responses.update_all(user_id: new_user.id)
      user.created_events.update_all(created_by: new_user.id)

      self.user = new_user
    end
  end

  def orphaned_user
    User.where(id: orphaned_user_id).first
  end

  def orphaned_user_id
    orphaned_user_id = changes.fetch(:user_id, []).first
    orphaned_user_id ||= previous_changes.fetch(:user_id, []).first
  end

  def self.authorize(auth, options = {})
    identity = Identity.where(provider: auth.provider, uid: auth.uid).first_or_initialize

    identity.assign_empty_attributes({
      full_name:  auth.info.name,
      first_name: auth.info.first_name,
      last_name:  auth.info.last_name,
      email:      auth.info.email,
      avatar_url: auth.info.image,
      token:      auth.credentials.token,
      auth_hash:  auth.to_h,
    })

    identity.merge_users(options[:user])
    identity.save

    identity
  end


end

