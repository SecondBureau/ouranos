class Page < ActiveRecord::Base
  scope :public_pages, lambda{ where("page_type = 'for_all'") }
  
  def page_type_enum
    [['for all', 'for_all'], ['for member', 'for_member']]
  end

end
