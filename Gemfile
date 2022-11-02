# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '3.1.2'
gem 'bootstrap', '~> 5.1.3'
gem 'rails', '~> 7.0.4'
gem 'sprockets-rails'
# gem "sqlite3", "~> 1.4"
gem 'bootsnap', require: false
gem 'importmap-rails'
gem 'jbuilder'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'brakeman'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'rails_best_practices', '~> 1.23', '>= 1.23.2'
  gem 'rubocop', require: false
end

group :development do
  gem 'annotate'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
