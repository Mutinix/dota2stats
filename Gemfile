source 'https://rubygems.org'
ruby "1.9.3"

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass', '3.2.13'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'omniauth-steam'
gem 'figaro'

gem 'jquery-rails'

gem 'nokogiri'

gem 'redis'
gem 'resque'
gem 'resque-web', require: 'resque_web'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'guard-spork'
  gem 'childprocess'
  gem 'spork'
  gem 'guard-rspec'
  gem "better_errors"
  gem 'annotate'
end

group :test do
  gem 'capybara'
  gem 'rb-fsevent', :require => false
  gem 'growl'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# Rails CMS Engine
# gem 'comfortable_mexican_sofa', '~> 1.8.0'

# Pagination
gem 'kaminari'