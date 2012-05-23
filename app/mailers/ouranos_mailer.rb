# encoding: utf-8
class OuranosMailer < ActionMailer::Base

  helper :mailers

  default :from => "romain@secondbureau.com"

  def newsletter
    date = DateTime.now
    subject = "Newsletter from APE LFIP on #{date.strftime("%m/%d/%Y")}"
    posts = Post.where("created_at > ?", date-1.month).order("created_at desc").limit(5)
    events = Event.where("created_at > ?", date-1.month).order("created_at desc").limit(5)

		users = User.all

		users.each do |user|
			newsletter(user, subject, posts, events)
		end
  end
  
  def newsletter(user, subject, posts, events)
    @user = user
    @user.reset_authentication_token!
    @subject = subject
    @posts = posts
    @events = events
    
    mail(:to => 'romain@secondbureau.com', :subject => @subject).deliver
  end
end