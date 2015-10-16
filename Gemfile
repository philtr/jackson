source "https://rubygems.org"

ruby "2.2.3"

gem "rails", "4.2.4"

gem "pg"

gem "omniauth", "~> 1.2"
gem "omniauth-facebook", "~> 2.0"
gem "omniauth-github", "~> 1.1"
gem "omniauth-gplus", "~> 2.0"
gem "omniauth-twitter", "~> 1.2"

gem "bootstrap-sass"
gem "bootswatch-rails"
gem "coffee-rails", "~> 4.1.0"
gem "dalli"
gem "haml", "~> 4.0.6"
gem "jquery-rails"
gem "maruku"
gem "nokogiri"
gem "postmark-rails"
gem "premailer-rails"
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 2.5"
gem "uglifier", "~> 2.7"
gem "unicorn"

group :development, :test do
  gem "better_errors"
  gem "binding_of_caller"
  gem "coveralls", require: false
  gem "dotenv-rails"
  gem "shoulda-matchers", "~> 3.0"
  gem "mailcatcher", github: "sj26/mailcatcher"
  gem "factory_girl_rails"
  gem "pry-rails"
  gem "rspec-rails"
end

group :production do
  gem "rails_12factor"
  gem "sentry-raven"
end
