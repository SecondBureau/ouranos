class User < ActiveRecord::Base
  include RorshackPermission::UserModelExt
  after_create :set_default_role
  has_one :account , :class_name => "RorshackAuthentication::Account" , :dependent => :destroy

  accepts_nested_attributes_for :account , :allow_destroy => true
  
  scope :members, lambda{all.select{|user| user.role.name == "member" }}
  
  def email
    self.account.email
  end
  
  protected

    def set_default_role
      self.role!( Role.default ) if self.role.nil?
    end

end
