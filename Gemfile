source "https://rubygems.org"

ruby "3.4.2"

gem "pg"
gem "puma"
gem "rails"

gem "devise"
gem "devise-jwt"
gem "fast_jsonapi"
gem "rack-cors"

gem "activeadmin"
gem "sass-rails"

gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  gem "brakeman", require: false
  gem "bullet"
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "dotenv"
  gem "factory_bot_rails"
  gem "faker"
  gem "pry"
  gem "rubocop-factory_bot"
  gem "rubocop-rails-omakase", require: false
  gem "rubocop-rspec"
  gem "rubocop-rspec_rails"
end

group :test do
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "simplecov", require: false
end
