source "http://rubygems.org"

# Declare your gem's dependencies in plazr_store.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

# This has to be here, since it doesn't work properly when added only to the dev group
# But we also can't add it as a global dependency, as it would become a dependency for apps using this engine
gem 'pry-rails'

# This one actually is actually better here. Otherwise any app using this engine would be forced to use pry
gem 'plazr_auth', :git => 'git@github.com:Plazr/plazr_auth.git'

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger

