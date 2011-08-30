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
      puts "======================================================================================"
    end
  end
  
  def update
    user = User.find params[:id]
    token = params[:token]
    puts "========================================== #{user.member_confirm.token == token}"
  end
  
private
  
  def check_member_confirmation
    if current_user.is_of_role?(:user) && current_user.member_confirm
      @has_send_confirm_email = true
    end
  end

end
