class MembershipController < ApplicationController

  def index
    @wana_be_member = true
  end

  def update
    user = User.find(params[:id])
    if !user
      redirect_to main_app.root_path, :notice => t("system.link.expired")
    end
    if user.member_confirm && user.member_confirm.token == params[:token]
      if !current_user
        sign_in(user)
      elsif current_user.email != user.email
        sign_out(current_user)
        sign_in(user)
      end
      user.member_confirm.delete
      user.save
      redirect_to main_app.root_path, :notice => t("account.alreadymember")
    else
      redirect_to main_app.root_path, :notice => t("system.link.expired")
    end

  end

end

