# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'pg', '~> 1.2.3'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3'
gem 'sass-rails', '>= 6'
gem 'twitter', '~> 7.0'

group :development do
  gem 'listen', '~> 3.3'
end

group :development, :test do
  gem 'coveralls', require: false
  gem 'pry-awesome_print', '~> 9.6.0'
  gem 'pry-rails',         '~> 0.3.0'
end

group :test do
  gem 'rspec-rails', '~> 4'
  gem 'rubocop', '~> 1.11'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
