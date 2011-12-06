# encoding: utf-8
class OuranosMailer < ActionMailer::Base
  
  helper :mailers

  default :from => "ape-lfip@ape-pekin.com" #,
          #:host => $host,
          #:asset_host => "http://" + $host

  def newsletter(user)
    @date = Time.now.strftime("%m/%d/%Y")
    @subject = "Newsletter from APE LFIP on #{@date}"
    @posts = Post.all.order("id desc").limit(5)
    @events = events.all.order("id desc").limit(5)
    mail(:to => user.email, :subject => @subject) do |format|
      format.html { render :layout => "newsletter" }
    end
  end

end
