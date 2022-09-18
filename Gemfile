source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

gem "rails", "~> 7.0.3"
gem 'sass-rails'
gem 'jquery-turbolinks'
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "devise", "~> 4.8"
gem 'tinymce-rails'
gem 'carrierwave'

#deploy-------------------------------------
gem 'capistrano', '~> 3.11'
      gem 'capistrano-rails', '~> 1.4'
      gem 'capistrano-passenger', '~> 0.2.0'
      gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'
#-------------------------------------------

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
end

