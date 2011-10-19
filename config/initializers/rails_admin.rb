RailsAdmin.config do |config|
  config.authorize_with :cancan
  
  config.excluded_models = ["MemberConfirm", "Subscribe", "Ckeditor::Asset", "Ckeditor::AttachmentFile", "Ckeditor::Picture"]
  
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
  
  config.model Comment do
    list do
      field :content
      field :user
    end
    edit do
      field :content, :text do
        ckeditor true
      end
      field :user_id do
        view_helper :hidden_field
        partial :form_field
        def value
          bindings[:view]._current_user.id
        end
        label "_"
        help "" 
      end 
    end
  end
  
  config.model Post do
    list do
      field :title
      field :user
      field :created_at
    end
    edit do
      field :title
      field :content, :text do
        ckeditor true
      end
      field :is_pinned
      field :user_id do
        view_helper :hidden_field
        partial :form_field
        def value
          bindings[:view]._current_user.id
        end
        label "_"
        help "" 
      end 
    end
  end
  
  config.model Page do
    list do
      field :title
      field :created_at
    end
    edit do
      field :title
      field :content, :text do
        ckeditor true
      end
    end
  end

  def custom_label_method
    "[#{self.role.name}] #{self.firstname} #{self.lastname}"
  end

end
