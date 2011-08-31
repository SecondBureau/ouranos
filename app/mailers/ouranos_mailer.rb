class OuranosMailer < ActionMailer::Base
  
  default :from => "ape-lfip @ape.com"
  
  def newsletter(user, posts, events)
    @date = Time.now.strftime("%m/%d/%Y")
    @subject = "Newsletter from APE LFIP on #{@date}"
    @posts = posts
    @events = events
    mail(:to => user.email, :subject => @subject) do |format|
      format.html { render :layout => "newsletter" }
    end
  end
  
  def membership_confirm(user, token)
    @date = Time.now.strftime("%m/%d/%Y")
    @subject = "Membership confirm from APE LFIP on #{@date}"
    @token = token
    @user = user
    mail(:to => user.email, :subject => @subject) do |format|
      format.html { render :layout => "membership_confirm" }
    end
  end
  
end
