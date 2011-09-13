RailsAdmin.config do |config|
  config.authorize_with :cancan
  
  config.included_models = ["User", "Comment", "Post", "Event", "Page", "Message", "Role", "Setting", "Subscribe"]
  
  config.model User do
    object_label_method do
      :custom_label_method
    end
    show do
      field :email
      field :role
      field :firstname
      field :lastname
      field :expiry_date
      field :sign_in_count
      field :current_sign_in_at
      field :last_sign_in_at
      field :current_sign_in_ip
      field :last_sign_in_ip
    end
    list do
      field :firstname
      field :role
      field :email
      field :expiry_date
      field :sign_in_count
      field :last_sign_in_at
    end
    edit do 
      field :email
      field :role do
        visible do
          bindings[:view].current_user.email != bindings[:object].email
        end
      end
      field :firstname
      field :lastname
      field :password
      field :password_confirmation
    end
  end
  
  config.model Post do
    edit do
      field :title
      field :content, :text do
        ckeditor true
      end
      field :can_be_subscribed do
        label "subscribed"
      end
      field :post_type
      field :user
    end
  end
  
  config.model Page do
    list do
      field :title
      field :created_at
      field :page_type
    end
    edit do
      field :title
      field :permalink
      field :page_type
      field :content, :text do
        ckeditor true
      end
    end
  end

  def custom_label_method
    "[#{self.role.name}] #{self.firstname} #{self.lastname}"
  end

end
