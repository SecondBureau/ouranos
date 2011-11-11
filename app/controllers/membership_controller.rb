class MembershipController < ApplicationController
  
  before_filter :authenticate_user!, :check_member_confirmation
  
  def index
    @wana_be_member = true
  end
  
  def show
    if !@has_send_confirm_email
      token = ActiveSupport::SecureRandom.hex(16)
      member_confirm = OuranosMailer.membership_confirm(current_user, token)
      member_confirm.deliver
      MemberConfirm.create({:user => current_user, :send_date => Time.now, :token => token})
      redirect_to main_app.root_path
    end
  end
  
  def update
    user = User.find(params[:id])
    if user.member_confirm.token == params[:token]
      if !current_user
        sign_in(user)
      elsif current_user.email != user.email
        sign_out(current_user)
        sign_in(user)
      end
      user.role = Role.find_by_name("member")
      user.expiry_date = DateTime.now + 7.days
      user.member_confirm.delete
      user.save
      redirect_to main_app.root_path, :notice => t("account.alreadymember")
    else
      redirect_to main_app.root_path, :notice => t("system.link.expired")
    end
    
  end
  
  private
    
    def check_member_confirmation
      if current_user && current_user.is_of_role?(:user) && current_user.member_confirm
        @has_send_confirm_email = true
      end
    end

end
