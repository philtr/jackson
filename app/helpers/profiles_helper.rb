module ProfilesHelper
  def provider?(provider_name)
    current_user.providers.include?(provider_name)
  end
end
