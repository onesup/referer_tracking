source "http://rubygems.org"

# Declare your gem's dependencies in referer_tracking.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
gem 'pry'

gem 'protected_attributes'
gem 'rails-observers'


# For travis testing
# http://schneems.com/post/50991826838/testing-against-multiple-rails-versions
rails_version = ENV["RAILS_VERSION"] || "default"
case rails_version
  when "default"
    gem "rails"
  else
    gem "rails", "~> #{rails_version}"
end
