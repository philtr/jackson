namespace :events do
  task :send_reminder_emails => :environment do
    Response.today.each do |response|
      if response.user.email.present?
        puts "Sending reminder email to #{ response.user.email }"
        EventMailer.event_is_today_reminder(response.user, response.event).deliver
      end
    end
  end
end
