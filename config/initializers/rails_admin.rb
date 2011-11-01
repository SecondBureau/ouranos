if ENV['init_rails_admin'] || true

  RailsAdmin.config do |config|
    config.authorize_with :cancan
    config.main_app_name = [ "APE FLIP", "Administration" ]
    config.included_models = ["Post", "Category", "Comment", "Event", "Page", "Role", "User", "Setting", "Image", "Person", "Family"]
    
    config.model Person do
      parent Family
      object_label_method do
        :person_label_method
      end
      edit do
        field :firstname
        field :lastname
        field :email
        field :birthdate
        field :family
        field :fa_type, :enum do
          enum do
            [['Mother', 'mother'], ['Father', 'father'], ['Kid', 'kid']]
          end
        end
      end
    end
    
    config.model User do
      parent Role
    end
    
    config.model Role do
      navigation_label 'Accounts'
      weight -1
    end
    
    config.model Family do
      navigation_label 'Members management'
      weight -3
    end

    config.model User do
      object_label_method do
        :user_label_method
      end
      label "Accounts"
      show do
        field :email
        field :role
        field :expiry_date
        field :sign_in_count
        field :current_sign_in_at
        field :last_sign_in_at
        field :current_sign_in_ip
        field :last_sign_in_ip
      end
      list do
        field :role
        field :email
        field :expiry_date
        field :sign_in_count
      end
      edit do
        field :email
        field :role
        field :password
        field :password_confirmation
      end
    end
    
    config.model Event do
      edit do
        field :title
        field :content, :text do
          ckeditor true
        end
        field :start_date
        field :end_date
      end
      list do
        field :title
        field :start_date
        field :end_date
      end
      show do
        field :title
        field :start_date
        field :end_date
      end
    end

    config.model Comment do
      parent Post
      list do
        field :content
        field :commentable do
          label "On"
        end
        field :user
        field :created_at
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
      navigation_label 'Post management'
      weight -2
      list do
        field :title
        field :user
        field :created_at
      end
      show do
        field :title
        field :user
      end
      edit do
        field :title
        field :locale, :enum do
          enum do
            [['French', 'fr'], ['Chinese', 'zh_cn']]
          end
        end
        field :categories
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
    
    config.model Image do
      list do
        field :title
        field(:image, :paperclip_file) do
          thumb_method :thumb
        end
      end
    end
    
    config.model Category do
      parent Post
      list do
        field :title
        field :description
        field :shows_at
      end
      edit do
        field :title
        field :description
        field :shows_at, :enum do
          enum do
            ['top', 'left']
          end
        end
        field :posts
      end
    end
    
    config.model Setting do
      label "Global Settings"
      list do 
        field :site_name
        field :contact_email
      end
      edit do
        field :images
        field :site_name
        field :contact_email
        field :send_email_after_user_created
      end
    end

    def user_label_method
      "#{self.role.name} - #{self.email}"
    end
    
    def family_label_method
      "#{self.name}"
    end
    
    def person_label_method
      "#{self.firstname} #{self.lastname}"
    end

  end

end

