# encoding: utf-8
class OuranosMailer < ActionMailer::Base

  default :from => "ape-lfip@ape-pekin.com" #,
          #:host => $host,
          #:asset_host => "http://" + $host

  layout 'ape'

  def newsletter(user)
    @date = Time.now.strftime("%m/%d/%Y")
    @subject = "Newsletter from APE LFIP on #{@date}"
    @posts = Post.all.order("id desc").limit(5)
    @events = events.all.order("id desc").limit(5)
    mail(:to => user.email, :subject => @subject) do |format|
      format.html { render :layout => "newsletter" }
    end
  end

  def membership_notice(user)
    @date = user.expires_at.strftime("%m/%d/%Y")
    @subject = "Membership will end in #{@date}"
    mail(:to => user.email, :subject => @subject) do |format|
      format.html { render :layout => "membership_notice" }
    end
  end

  def membership_confirm(user, token)
    @date = Time.now.strftime("%m/%d/%Y")
    @subject = "Membership confirm from APE LFIP on #{@date}"
    @token = token
    @user = user
    mail(:to => user.email, :subject => @subject) do |format|
      format.html { render :layout => "membership_confirm" }
      format.text { render :layout => "membership_confirm" }
    end
  end

  def membership_welcome(user)
    @user           = user
    @password       = SecureRandom.hex(3)
    @subject        = "Bienvenue sur le Site de l'APE LFIP"
    @email_extract  = "Veuillez trouver votre mot de passe pour acceder au site de l'APE du LFIP."
    @is_archive_page = true
    user.update_attributes( :password => @password, :password_confirmation => @password )
    mail(:to => user.email, :subject => @subject)
  end

end
