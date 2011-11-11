class Family < ActiveRecord::Base
  belongs_to :user
  has_many :people
end
