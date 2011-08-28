class Newsletter < ActionMailer::Base
  
  default :from => "Newsletter.ape@ape.com"
  
  def newsletter(user)
    @subject = "Newsletter from APE LFIP #{Time.now}"
    mail(:to => "mark@secondbureau.com", :subject => @subject) do |format|
      format.html
    end
  end
  
end
