class Role < ActiveRecord::Base

  MEMBER = 'member'
  ADMIN = 'administrator'

  validates_presence_of :name
  has_many :users
end

