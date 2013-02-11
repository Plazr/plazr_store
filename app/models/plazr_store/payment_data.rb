# encoding: utf-8
module PlazrStore
  class PaymentData < ActiveRecord::Base
    ## Relations ##
    # belongs_to :user TODO metodo que chama api
    # belongs_to :payment_method TODO aqui tb é metodo que chama api?
    belongs_to :bill_address, :class_name => "Address"
    belongs_to :ship_address, :class_name => "Address"

    has_many :orders

    ## Attributes ##
    attr_accessible :payment_data, :state, :total
  end
end
