Refinery::User.class_eval do
  
    # Migration
    # To be removes
    attr_accessible :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :sign_in_count
  
    # Groups
    belongs_to :group, :class_name => "Refinery::Groups::Group"
    attr_accessible :group_id
    attr_accessible :group_admin
    delegate :expired?, :to => :group, :allow_nil => true
    
    # MailChimp
    before_create   :subscribe_or_update
    before_update   :subscribe_or_update
    before_destroy  :unsubscribe
    attr_accessor :bypass_mailchimp
    
    # Token Authentication
    devise :token_authenticatable
    attr_accessible :authentication_token
    before_save :reset_authentication_token, :unless => :authentication_token
    
    # new attributes
    before_validation :update_position_updated_at, :if => :position_changed?
    attr_accessible :position, :position_updated_at, :firstname, :lastname, :optin_newsletters
    attr_accessor :bypass_update_position # TODO : remove bypass after migration
    
    
    # Hack : Allow Empty Emails on Front End
    EMPTY_DOMAIN_NAME = 'example.org'
    before_validation :hack_empty_email, :unless => :optin_newsletters
    

    #TODO
    def is_expired?
      false
    end

    #TODO
    def slug
      self.username
    end
    
    def unhacked_email
      email[-11,11].eql?(EMPTY_DOMAIN_NAME) ? nil : email
    end
    
    def bypass_mailchimp
      @bypass_mailchimp || false
    end
    
    private
    
    def hack_empty_email
      self.email = "#{username}@#{EMPTY_DOMAIN_NAME}" if email.blank?
    end
    
    def update_position_updated_at
      # TODO : remove bypass after migration
      self.position_updated_at = Time.now unless bypass_update_position
    end
    
    def unsubscribe
      return if (group.nil? || bypass_mailchimp)
      unsubscribe_mailchimp(email)
    end
    
    def subscribe_or_update
      return if (group.nil? || bypass_mailchimp)
      unsubscribe_mailchimp(email_was) if email_changed? && !email_was.nil?
      unless unhacked_email.nil?
        if optin_newsletters
          subscribe_mailchimp(email) unless (changed & mailchimp_list_fields).empty?
        else
          unsubscribe_mailchimp(email) if optin_newsletters_changed?
        end
      end
    end
    
    def mailchimp_merge_vars
      { :FNAME => firstname || username , :LNAME => lastname || username, :TOKEN => authentication_token, :FAMILY => group.name }
    end
    
    def mailchimp_list_fields
      %w(firstname lastname username authentication_token group_id optin_newsletters email)
    end
    
    def subscribe_mailchimp(email)
      Gibbon.throws_exceptions = false
      res = Gibbon.list_subscribe(:id => Refinery::Groups.list_id, :email_address  => email, :merge_vars => mailchimp_merge_vars, :double_optin   => false)
      
      # Catch some errors:
      # if already subscribed, just update the member info
      # puts res.inspect
      update_mailchimp(email) if res.is_a?(Hash) && res["code"] == 214
    end
    
    def update_mailchimp(email)
      Gibbon.list_update_member(:id => Refinery::Groups.list_id, :email_address  => email, :merge_vars => mailchimp_merge_vars)
    end

    def unsubscribe_mailchimp(email)
      Gibbon.list_unsubscribe(:id => Refinery::Groups.list_id, :email_address  => email, :delete_member  => true, :send_goodbye   => false, :send_notify    => false)
    end
    
    

end
