source 'https://rubygems.org'
#ruby "1.9.3"
gem 'rails', '3.2.6'


# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Database gems
platforms :mri_19, :mingw_19 do
  group :postgresql do
    gem "pg", ">= 0.11.0"
  end
end

platforms :mri_18, :mingw_18 do
  group :mysql do
    gem "mysql"
  end
end

gem "thin"
gem "yard"

gem "devise"
gem "acts_as_follower"
gem "acts-as-taggable-on", "~> 2.3.1"
gem 'will_paginate', '~> 3.0'
gem "heroku"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
