class MembershipController < ApplicationController
  
  before_filter :check_member_confirmation
  
  def index
    @wana_be_member = true
  end
  
  def show
    if !@has_send_confirm_email
      token = ActiveSupport::SecureRandom.hex(16)
      member_confirm = OuranosMailer.membership_confirm(current_user, token)
      member_confirm.deliver
      MemberConfirm.create({:user => current_user, :send_date => Time.now, :token => token})
    end
  end
  
  def update
    sign_in(User.find(params[:id]))
    user = User.find params[:id]
    token = params[:token]
    if user.member_confirm.token == token
      user.role = Role.where("name = ?", "member").first
      user.member_confirm.delete
      user.save
      redirect_to main_app.root_path, :notice => "You are a member now."
    end
  end
  
private
  
  def check_member_confirmation
    if current_user && current_user.is_of_role?(:user) && current_user.member_confirm
      @has_send_confirm_email = true
    end
  end

end
