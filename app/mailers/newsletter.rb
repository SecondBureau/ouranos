class Newsletter < ActionMailer::Base
  
  default :from => "newsletter.ape@ape.com"
  
  def newsletter(user, posts, events)
    @date = Time.now.strftime("%m/%d/%Y")
    @subject = "Newsletter from APE LFIP on #{@date}"
    @posts = posts
    @events = events
    mail(:to => user.email, :subject => @subject) do |format|
      format.html
    end
  end
  
end
