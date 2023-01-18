source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "7.0.3.1"
gem "sprockets-rails"
gem "puma", "~> 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "devise"
gem "devise-i18n"
gem "rails-i18n"

# For Windows: Install ImageMagick to C:/ImageMagick
# gem install rmagick --platform=ruby -- --with-opt-lib=c:/ImageMagick/lib --with-opt-include=c:/ImageMagick/include
gem "rmagick"
gem "carrierwave"

gem "mailjet"
gem "dotenv-rails"

# gem "paper_trail"

group :development, :test do
  gem "sqlite3", "~> 1.4"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
end

group :production do
  gem "pg", "~> 1.1"
end

