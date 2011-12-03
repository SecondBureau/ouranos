# encoding: utf-8
class OuranosMailer < ActionMailer::Base
  
  helper :mailers

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



end
