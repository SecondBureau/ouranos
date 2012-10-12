class Post < ActiveRecord::Base


  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_and_belongs_to_many :categories

 
  attr_accessor :keep_cache

  

end
