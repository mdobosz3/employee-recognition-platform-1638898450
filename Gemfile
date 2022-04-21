# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

gem 'active_storage_validations'
gem 'aws-sdk-s3', require: false
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise', '~> 4.8'
gem 'faker', '~> 1.6', '>= 1.6.3'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'pundit'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'sass-rails', '>= 6'
gem 'searchlight'
gem 'webpacker', '~> 5.0'

group :development, :test do
  # Debugging tool
  gem 'pry-rails'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  # Tests
  gem 'bullet', group: 'development'
  gem 'capybara', '~> 3.36'
  gem 'factory_bot_rails'
  gem 'letter_opener', group: 'development'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'selenium-webdriver', '~> 4.1'
  gem 'shoulda-matchers', '~> 5.0'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
