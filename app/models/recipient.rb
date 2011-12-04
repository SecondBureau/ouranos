class Recipient < ActiveRecord::Base
  belongs_to :user
  serialize :params
  

end
