Refinery::User.class_eval do
  
    # Migration
    # To be removes
    attr_accessible :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :sign_in_count
  
    # Groups
    belongs_to :group, :class_name => "Refinery::Groups::Group"
    attr_accessible :group_id
    
    # MailChimp
    before_create   :subscribe
    before_update   :update_subscribe_in_mailchimp
    before_destroy  :unsubscribe
    
    # Token Authentication
    devise :token_authenticatable
    attr_accessible :authentication_token
    before_save :reset_authentication_token, :unless => :authentication_token
    
    # Bugfix
    before_validation :parameterize_username

    # new attributes
    attr_accessible :position, :firstname, :lastname

    #TODO
    def is_expired?
      false
    end

    #TODO
    def slug
      self.username
    end
    
    
    def subscribe
      # DESACTIVE MAILCHIMP
      return
      return if self.group.nil?

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
      return
      return if self.group.nil?

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
      return
      return if self.group.nil?

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
    
    def parameterize_username
      self.username = username.parameterize
    end

end
