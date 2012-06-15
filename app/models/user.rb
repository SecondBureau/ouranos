class User < ActiveRecord::Base

  DEFAULT_TRIAL_PERIOD = 7
  DEFAULT_ROLE = Role::MEMBER

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable, :confirmable
  devise :token_authenticatable,
         :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :expires_at, :role_id, :authentication_token

  belongs_to :role
  has_many :subscribes
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_one :family
  has_many :recipients

  before_create :set_default_attributes
  before_validation :forge_email


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

  def check_active_subscription
    if (sign_in_count || 0).eql?(1)
    Recipient.create(:user => self, :template => 'welcome')
    elsif !expires_at.nil? && (expires_at - Time.now > (Setting.first.trial_period || DEFAULT_TRIAL_PERIOD) * 60 * 60 * 24)
      Recipient.create(:user => self, :template => 'will_soon_expire')
    end
  end

  def forge_email
    unless ::Rails.env.eql?('production')
      self.email = "#{self.email.gsub('@' + $catch_all_domain_name,'').gsub('@','.')}@#{$catch_all_domain_name}"
    end
  end

  def self.forge_all_emails
    User.all.each{ |_| _.save }
  end

  # deprecated
  def to_s
    "#{email}"
  end

private

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
