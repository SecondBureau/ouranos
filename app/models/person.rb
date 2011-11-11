class Person < ActiveRecord::Base
  
  belongs_to :family
  
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  def to_s
    "#{firstname} #{lastname}"
  end

end
