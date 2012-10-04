Refinery::Groups::Admin::UsersController.class_eval do
  
   protected

    def find_user_with_slug
      begin
        find_user_without_slug
      rescue ActiveRecord::RecordNotFound
        @user = Refinery::User.all.detect{|u| u.to_param == params[:id]}
      end
    end
    alias_method_chain :find_user, :slug
    
end