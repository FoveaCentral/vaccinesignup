# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '>= 3.0'

gem 'puma', '~> 6.4'
gem 'rails', '~> 7.1.3'
gem 'sprockets-rails', '~> 3.5'
gem 'twitter', '~> 8.1'

group :development do
  gem 'listen', '~> 3.9'
  gem 'spring', '~> 4.2'
  gem 'spring-commands-rspec', '~> 1.0'
end

group :development, :production do
  gem 'pg', '~> 1.5.8'
end

group :development, :test do
  gem 'inch', '~> 0.8'
  gem 'pry-awesome_print', '~> 9.6.0'
  gem 'pry-rails',         '~> 0.3.11'
end

group :test do
  gem 'database_cleaner-active_record', '~> 2.2'
  gem 'factory_bot', '~> 6.5'
  gem 'rspec-rails', '~> 7'
  gem 'rubocop', '~> 1.67'
  gem 'rubocop-rails', '~> 2.26'
  gem 'rubocop-rspec', '~> 3.1'
  gem 'simplecov', require: false
  gem 'simplecov-lcov', require: false
  gem 'sqlite3', '~> 1.7'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
