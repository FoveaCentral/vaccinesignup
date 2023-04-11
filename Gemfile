# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '>= 2.7'

gem 'puma', '~> 6.2'
gem 'rails', '~> 6.1.4'
gem 'twitter', '~> 7.0'

group :development do
  gem 'listen', '~> 3.8'
  gem 'spring', '~> 4.1'
  gem 'spring-commands-rspec', '~> 1.0'
end

group :development, :production do
  gem 'pg', '~> 1.4.6'
end

group :development, :test do
  gem 'inch', '~> 0.8'
  gem 'pry-awesome_print', '~> 9.6.0'
  gem 'pry-rails',         '~> 0.3.0'
end

group :test do
  gem 'database_cleaner-active_record', '~> 2.1'
  gem 'factory_bot', '~> 6.2'
  gem 'rspec-rails', '~> 6'
  gem 'rubocop', '~> 1.50'
  gem 'rubocop-rails', '~> 2.19'
  gem 'rubocop-rspec', '~> 2.19'
  gem 'simplecov', require: false
  gem 'simplecov-lcov', require: false
  gem 'sqlite3', '~> 1.6'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
