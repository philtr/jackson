source 'https://rubygems.org'

ruby "2.1.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

gem 'pg'

gem 'omniauth', '~> 1.2.1'
gem 'omniauth-facebook', '~> 1.6.0'
gem 'omniauth-github', '~> 1.1.1'
gem 'omniauth-twitter', '~> 1.0.1'

gem 'coffee-rails', '~> 4.0.1'
gem 'dotenv-rails', '~> 0.9.0'
gem 'haml', '~> 4.0.5'
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails'
gem 'maruku'
gem 'nokogiri'
gem 'postmark-rails'
gem 'premailer-rails'
gem 'sass-rails', '~> 4.0.1'
gem 'uglifier', '>= 2.4.0'
gem 'unicorn'

group :development, :test do
  gem 'coveralls', require: false
  gem 'shoulda-context'
  gem 'shoulda-matchers'
  gem 'mailcatcher', github: "sj26/mailcatcher"
  gem 'factory_girl_rails'
  gem 'mocha', require: false
  gem 'pry-rails'
  gem 'turn'
end

group :production do
  gem 'rails_12factor'
  gem 'sentry-raven'
end
