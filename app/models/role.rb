class Role < ActiveRecord::Base

  MEMBER = 'member'
  ADMIN = 'administrator'

  
  has_many :users
end

