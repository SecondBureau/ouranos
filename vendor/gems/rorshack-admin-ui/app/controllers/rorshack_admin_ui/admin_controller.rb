module RorshackAdminUi
  
  class AdminController < ApplicationController

    layout "admin_ui"
    
    def list
      @model_names = RorshackAdminUi::ADMINABLE_MODELS.map{|_| _.is_a?(Hash) ? _.keys.first : _}
    end
    
  end
  
end
