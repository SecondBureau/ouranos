if $init_rails_admin || Rails.env.development?

  RailsAdmin.config do |config|
    config.authorize_with :cancan
    config.default_items_per_page = 10
    config.main_app_name = [ "APE LFIP", "Administration" ]
    config.included_models = ["Post", "Category", "Comment", "Event", "Page", "Role", "User", "Setting", "Image", "Person", "Family", "Resource"]

    config.model Person do
      parent Family
      object_label_method do
        :person_label_method
      end
      list do
        field :firstname
        field :lastname
        field :fa_type
        field :family
        field :email
        field :birthdate
      end
      show do
        field :firstname
        field :lastname
        field :fa_type
        field :family
        field :email
        field :birthdate
      end
      edit do
        field :firstname
        field :lastname
        field :family
        field :email
        field :birthdate
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
      navigation_label 'Accounts management'
      weight -1
    end

    config.model Family do
      navigation_label 'Members management'
      weight -3
      list do
        field :name
        field :user do
          label 'Account'
        end
      end
      edit do
        field :name
        field :user do
          label 'Account'
        end
        field :people
      end
      show do
        field :name
        field :user do
          label 'Account'
        end
      end
    end

    config.model User do
      object_label_method do
        :user_label_method
      end
      label "Accounts"
      show do
        field :email
        field :role
        field :expires_at
        field :sign_in_count
        field :current_sign_in_at
        field :last_sign_in_at
        field :current_sign_in_ip
        field :last_sign_in_ip
      end
      list do
        field :role
        field :email
        field :sign_in_count
      end
      edit do
        field :email
        field :role
        field :password
        field :password_confirmation
        field :expires_at
      end
    end

    config.model Event do
      weight +9
      edit do
        field :title
        field :content, :text do
          tinymce true
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
        field :user do
          label 'Account'
        end
        field :created_at
      end
      edit do
        field :content, :text
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
        field :read_count do
          label 'Readed times'
        end
      end
      show do
        field :title
        field :user
        field :read_count do
          label 'Readed times'
        end
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
          tinymce true
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
      weight +10
      list do
        field :title
        field :created_at
      end
      edit do
        field :title
        field :content, :text do
          tinymce true
        end
      end
    end

    config.model Resource do
      navigation_label 'Resources management'
      weight +1
      label "Files"
      object_label_method do
        :resource_label_method
      end
      list do
        field :title
        field :resource, :paperclip_file
      end
    end

    config.model Image do
      parent Resource
      weight +1
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
      label "Settings"
      object_label_method do
        :setting_label_method
      end
      index :show
      weight -10
      show do
        field :images
        field :site_name
        field :contact_email
        field :trial_period
      end
      edit do
        field :images
        field :site_name
        field :contact_email
        field :trial_period
        field :images do
          label "Banner images"
        end
      end
    end

    def setting_label_method
      "settings"
    end

    def user_label_method
      "#{self.email}"
    end

    def resource_label_method
      "resource: #{self.title}"
    end

    def post_label_method
      "#{self.title}"
    end

    def family_label_method
      "#{self.name}"
    end

    def person_label_method
      "#{self.firstname} #{self.lastname}"
    end

  end

end
