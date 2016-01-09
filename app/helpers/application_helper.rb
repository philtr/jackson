module ApplicationHelper
  def markdownify(text)
    camouflage_images(Maruku.new(text).to_html).html_safe
  end

  def camouflage_images(html)
    return html unless ENV["CAMO_HOST"].present?

    doc = Nokogiri::HTML(html)

    doc.css("img").each do |image|
      image["src"] = camo_url(image["src"])
    end

    doc.to_html
  end

  def camo_url(url)
    digest = OpenSSL::HMAC.hexdigest(
      OpenSSL::Digest.new("sha1"), ENV["CAMO_KEY"], url)

    "https://#{ENV['CAMO_HOST']}/#{digest}?url=#{url}"
  end
end
