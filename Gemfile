source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem 'bcrypt', '3.1.12'
gem 'bootstrap-social-rails'
gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'font-awesome-rails'
gem 'faker', '2.10.2'
gem 'carrierwave', '1.2.2'
gem 'mini_magick', '4.7.0'
# gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'will_paginate',           '3.1.7'
gem 'bootstrap-will_paginate', '1.0.0'
gem 'bootstrap-sass', '3.3.7'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'jquery-rails', '4.3.1'
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'sqlite3', '1.4.2'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'spring-commands-rspec'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  # gem 'rails-footnotes', '4.1.5'

  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop-airbnb'
  gem 'rubocop', '0.76.0'
  gem 'rubocop-rspec', '1.30.1'
end

group :production do
  gem 'pg', '1.2.3'
  gem 'fog', '1.42'
end

group :test do
  gem 'rspec-rails', '4.0.0.rc1'
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem "selenium-webdriver"
  gem "shoulda-matchers",
      git: 'https://github.com/thoughtbot/shoulda-matchers.git',
      branch: 'rails-5'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
