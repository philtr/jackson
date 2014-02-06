if ENV["POSTMARK_API_KEY"].present?
  ActionMailer::Base.delivery_method = :postmark
  ActionMailer::Base.postmark_settings = { api_key: ENV["POSTMARK_API_KEY"] }
else # MailCatcher
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = { address: "localhost", port: "1025" }
end

