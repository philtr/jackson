if ENV["DEFAULT_URL_HOST"].present?
  Rails.application.routes.default_url_options[:host] = ENV["DEFAULT_URL_HOST"]
end

