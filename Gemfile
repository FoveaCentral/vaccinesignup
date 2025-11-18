# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.10'

gem 'puma'
gem 'rails'
gem 'sprockets-rails'
gem 'twitter'

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :development, :production do
  gem 'pg'
end

group :development, :test do
  gem 'inch'
  gem 'pry-awesome_print'
  gem 'pry-rails'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'factory_bot'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-factory_bot'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'rubocop-rspec_rails'
  gem 'simplecov', require: false
  gem 'simplecov-lcov', require: false
  gem 'sqlite3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
