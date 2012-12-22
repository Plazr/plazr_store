# Load the rails application
require File.expand_path('../application', __FILE__)
require 'will_paginate'
require 'will_paginate/array'

# Initialize the rails application
Dummy::Application.initialize!

# Alias for namespace
PZS = PlazrStore
