# frozen_string_literal: true

# rubocop:disable Style/FetchEnvVar
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)
# rubocop:enable Style/FetchEnvVar

require 'bundler/setup' # Set up gems listed in the Gemfile.
