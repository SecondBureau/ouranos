class User < ActiveRecord::Base

  DEFAULT_TRIAL_PERIOD = 7
  DEFAULT_ROLE = Role::MEMBER

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable, :confirmable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :expires_at, :role_id

  belongs_to :role
  has_many :subscribes
  has_many :comments, :as => :commentable
  has_one :member_confirm
  has_one :family

  after_create :send_membership_email
  before_create :set_default_attributes


  def is_role? role_name
    role && role.name.eql?(role_name)
  end

  def is_member?
    is_role? Role::MEMBER
  end

  def is_admin?
    is_role? Role::ADMIN
  end

  def is_expired?
    (expires_at.nil? || !expires_at.is_a?(Time) || expires_at > Time.now) ? false : true
  end

  # deprecated
  def to_s
    "#{email}"
  end


private

  # deprecated
  def send_membership_email
    if Setting.first.send_email_after_user_created
      token = SecureRandom.hex(16)
      OuranosMailer.membership_confirm(self, token).deliver
      MemberConfirm.create({:user => self, :send_date => Time.now, :token => token})
    end
  end

  def set_default_expiration_date
    self.expires_at = Time.now + (Setting.first.trial_period || DEFAULT_TRIAL_PERIOD) * 60 * 60 * 24 if expires_at.nil?
  end

  def set_default_role
    self.role = Role.find_by_name(DEFAULT_ROLE) unless role
  end

  def set_default_attributes
    set_default_expiration_date
    set_default_role
  end

end

