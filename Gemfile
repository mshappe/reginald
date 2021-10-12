# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'
gem 'aasm'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise'
gem 'factory_bot_rails'
gem 'faker'
gem 'jbuilder', '~> 2.7'
gem 'kaminari'
gem 'paper_trail'
gem 'pg'
gem 'puma', '~> 5.5'
gem 'pundit'
gem 'rails', '~> 6.1.4'
gem 'ransack'
gem 'rolify'
gem 'sass-rails', '>= 6'
gem 'slim-rails'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rexml'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
  gem 'shoulda-matchers'
end

group :development do
  gem 'annotate'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0', require: false
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
