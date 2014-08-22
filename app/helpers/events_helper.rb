module EventsHelper
  def google_maps_link(location)
    link_to location, "https://www.google.com/maps/preview/search/#{ URI.escape(location) }" unless location.nil?
  end

  def name_and_guests(resp)
    %(#{ resp.user.first_name } #{ resp.user.last_name } <span class="label label-danger">+#{ resp.additional_guests }</span>)
  end
end
