module EventsHelper
  def google_maps_link(location)
    link_to location, "https://www.google.com/maps/preview/search/#{ URI.escape(location) }" unless location.nil?
  end

  def response_popover(resp)
    comment = markdownify(resp.comments).html_safe
    name = [ resp.user.first_name, resp.user.last_name ].compact.join(" ")
    guests = resp.additional_guests

    render "events/response_popover", comment: comment, name: name, guests: guests
  end
end
