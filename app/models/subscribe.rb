class Subscribe < ActiveRecord::Base
  belongs_to :user
  
  def type_enum
    [['for all', 'for_all'], ['for member', 'for_member']]
  end
  
end
