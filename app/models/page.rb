class Page < ActiveRecord::Base
  
  scope :public_pages, lambda{ where("page_type = 'public'") }
  
end
