# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.0"

gem "bootsnap", ">= 1.1.0", require: false
gem "mysql2", ">= 0.4.4", "< 0.6.0"
gem "puma", "~> 3.11"
gem "rails", "~> 5.2.1", ">= 5.2.1.1"

gem "rack-cors"

group :development, :test do
  gem "factory_bot_rails"
  gem "faker"
  gem "pry"
  gem "rspec-rails"
end

group :test do
  gem "database_cleaner"
  gem "shoulda-matchers"
  gem "simplecov"
end

group :development do
  gem "brakeman", require: false
  gem "bundler-audit", require: false
  gem "rubocop", require: false
  gem "rubocop-rspec", require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
