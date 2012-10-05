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
    before_create   :subscribe
    before_update   :update_subscribe_in_mailchimp
    before_destroy  :unsubscribe
    attr_accessor :bypass_mailchimp
    
    # Token Authentication
    devise :token_authenticatable
    attr_accessible :authentication_token
    before_save :reset_authentication_token, :unless => :authentication_token
    
    # new attributes
    before_validation :update_position_updated_at, :if => :position_changed?
    attr_accessible :position, :position_updated_at, :firstname, :lastname, :optin_newsletters
    
    
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
    
    def subscribe
      return if (group.nil? || bypass_mailchimp)

      merge_vars = {
        :FNAME => firstname || username ,
        :LNAME => lastname || username,
        :TOKEN => authentication_token,
        :FAMILY => group.name
      }
      res = Gibbon.list_subscribe(:id             => Refinery::Groups.list_id,
                                  :email_address  => self.email,
                                  :merge_vars     => merge_vars,
                                  :double_optin   => false)
      # if already subscribed, just update the member info
      if res.is_a?(Hash) && res["code"] == 214
        res = Gibbon.list_update_member(:id       => Refinery::Groups.list_id,
                                  :email_address  => self.email,
                                  :merge_vars     => merge_vars)
        #Rails.logger.info(res) if res.is_a?(Hash)
      end
    end

    def unsubscribe
      return if (group.nil? || bypass_mailchimp)

      Gibbon.list_unsubscribe(:id             => Refinery::Groups.list_id,
                              :email_address  => self.email,
                              :delete_member  => true,
                              :send_goodbye   => false,
                              :send_notify    => false)
    end
    
    # mailchimp list fields | merge vars like *|FIRST_NAME|* *|EMAIL|* *|TOKEN|*
    def mailchimp_list_fields
      %w(firstname lastname authentication_token email)
    end

    def update_subscribe_in_mailchimp
      return if (group.nil? || bypass_mailchimp)

      unless (changed & mailchimp_list_fields).empty?

        merge_vars = {
          :FNAME => firstname || username ,
          :LNAME => lastname || username,
          :TOKEN => authentication_token,
          :FAMILY => group.name
        }
        Gibbon.list_update_member(:id             => Refinery::Groups.list_id,
                                  :email_address  => self.email,
                                  :merge_vars     => merge_vars)
      end
    end

    
    private
    
    def hack_empty_email
      self.email = "#{username}@#{EMPTY_DOMAIN_NAME}" if email.blank?
    end
    
    def update_position_updated_at
      self.position_updated_at = Time.now
    end
    


end
