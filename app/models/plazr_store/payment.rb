module PlazrStore
  class Payment < ActiveRecord::Base
    # Overrides some basic methods for the current model so that calling #destroy sets a 'deleted_at' field to the current timestamp
    include PZS::ParanoiaInterface

    ## Relations ##
    belongs_to :order
    belongs_to :payment_method

    ## Atributtes ##
    attr_accessible :state, :total, :order_id, :payment_method_id
  end
end
