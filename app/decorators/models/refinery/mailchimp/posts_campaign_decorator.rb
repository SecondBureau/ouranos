Refinery::Mailchimp::PostsCampaign.class_eval do 
  
  protected
  
    def create_mailchimp_campaign
      options = { :subject => subject, :from_email => from_email, :from_name => from_name, :list_id => mailchimp_list_id, :auto_tweet => auto_tweet }
      options[:template_id] = mailchimp_template_id unless mailchimp_template_id.blank?
      options[:tracking] = {"opens" => true, "html_clicks" => true, "text_clicks" => true}
      options[:analytics] = {"google" => "NL_#{Time.now.year}"}
      
      self.mailchimp_campaign_id = begin
        cid = Refinery::Mailchimp::API.new.campaign_create 'regular', options, body
        if self.target_users != "all_users"
          self.update_static_segments 
          Gibbon.campaign_update(:cid => cid, :name => "segment_opts", :value => self.send(self.target_users.to_sym))
        end
        cid
      rescue Hominid::APIError => e
        halt_with_mailchimp_error e
        return false
      end
    end
    
    def update_mailchimp_campaign
      return if new_record?
      client = Refinery::Mailchimp::API.new

      options = {:title => :subject, :from_email => :from_email, :from_name => :from_name, :list_id => :mailchimp_list_id, :template_id => :mailchimp_template_id, :content => :body, :auto_tweet => :auto_tweet }
      options.each_pair do |option_name, attribute|
        if changed.include?(attribute.to_s)
          begin 
            success = client.campaign_update mailchimp_campaign_id, option_name, self.send(attribute)
          rescue Hominid::APIError => e
            return halt_with_mailchimp_error e
          end
        end
      end
    end
    
    
end