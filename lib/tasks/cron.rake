namespace :cron do
  desc "mail and newsletter"
  task :send_newsletter => :environment do
  
    date = DateTime.now
    subject = "Newsletter from APE LFIP on #{date.strftime("%m/%d/%Y")}"
  
    posts = Post.order('created_at ASC').where(:sent_at => nil)
    events = Event.order('created_at ASC').where(:sent_at => nil)
    
    begin
      posts_ids = []
      posts.each do |post|
        post.sent_at = DateTime.now
        post.save!
        posts_ids << post.id
        puts post.id
      end
      
      events_ids = []
      events.each do |event|
        event.sent_at = DateTime.now
        event.save!
        events_ids << event.id
        puts event.id
      end
    
      users = User.where(:newsletter => true)
      users.each do |user|
        Recipient.create(:user => user, :template => 'newsletter', :params => {:subject => subject, :posts => posts_ids, :events => events_ids})
      end
      
    rescue Exception=>e
      #Problem
    end
    Rake::Task['mailer:send_emails'].invoke
  end
end