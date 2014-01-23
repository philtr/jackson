module EventsHelper
  def google_maps_link(location)
    link_to location, "https://www.google.com/maps/preview/search/#{ URI.escape(location) }" unless location.nil?
  end
end
