class Newsletter < ActionMailer::Base
  
  default :from => "Newsletter.ape@ape.com"
  
  def newsletter(user, posts, events)
    @subject = "Newsletter from APE LFIP #{Time.now}"
    @posts = posts
    @events = events
    mail(:to => user.email, :subject => @subject) do |format|
      format.html
    end
  end
  
end
