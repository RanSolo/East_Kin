source 'https://rubygems.org'
ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'animate-scss'
gem 'rails'
# Use SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass', '~> 3.3'
gem 'sass-rails', '~> 5.0'
gem 'twitter-bootstrap-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.37'
gem 'fullcalendar-rails'
gem 'momentjs-rails', '>= 2.9.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'lodash-rails'
# Turbolinks makes following links in your web application faster. Read more:
# https://github.com/rails/turbolinks
gem 'jquery-turbolinks'
gem 'turbolinks', '~> 5.0.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
gem 'meta-tags'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'execjs'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger
  # console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
end

gem 'cancan'
gem 'devise'
gem 'httparty'
gem 'kaminari'
gem 'nori'
gem 'puma'
gem 'twilio-ruby'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development do
  gem 'bullet'
  gem 'letter_opener'
end

group :development, :test do
  gem 'brakeman', require: false
  gem 'database_cleaner'
  gem 'rubocop'
  gem 'rubocop-checkstyle_formatter', require: false
  gem 'sqlite3'
end

group :test do
  # gem 'capybara-webkit'
  # gem 'capybara-screenshot'
  gem 'ci_reporter_minitest'
  gem 'simplecov', require: false
  gem 'vcr'
  gem 'webmock'
end
