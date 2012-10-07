class User < ActiveRecord::Base


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :expires_at, :role_id, :authentication_token, :newsletter_sent_at, :opt_in_newsletter

  belongs_to :role
  has_many :subscribes
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_one :family
  has_many :recipients


end
