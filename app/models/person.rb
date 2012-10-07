class Person < ActiveRecord::Base

  belongs_to :family

 
  def to_s
    "#{firstname} #{lastname}"
  end

end

