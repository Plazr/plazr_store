# encoding: utf-8
require 'active_support/concern'

module PlazrStore
  module ParanoiaInterface
    extend ActiveSupport::Concern
    included do
      class_eval do
        acts_as_paranoid
      end
    end
  end
end 
