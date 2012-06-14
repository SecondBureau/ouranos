namespace :mailer do
  desc "send unsent emails"
  task :send_emails => :environment do |t, args|
    Recipient.where(:sent_at => nil).each do |recipient|
      RecipientMailer.send(recipient.template, recipient)
    end
  end

  desc "prepare newsletter"
  task :prepare_newsletter => :environment do
    date = DateTime.now
    subject = t("newsletter.subject") + " #{I18n.l(date, :format => "%e %B %Y")}"

    posts = Post.order('created_at ASC').where(:sent_at => nil)
    events = Event.order('created_at ASC').where(:sent_at => nil)

    begin
      posts_ids = []
      posts.each do |post|
        post.sent_at = DateTime.now
        post.save!
        posts_ids << post.id
      end

      events_ids = []
      events.each do |event|
        event.sent_at = DateTime.now
        event.save!
        events_ids << event.id
      end

      if posts_ids.length > 0 || events_ids.length > 0
        users = User.where(:opt_in_newsletter => true, :newsletter_sent_at < DateTime.now-1.month)
        users.each do |user|
          Recipient.create(:user => user, :template => 'newsletter', :params => {:subject => subject, :posts => posts_ids, :events => events_ids})
        end
      end

    rescue Exception=>e
      #Problem
    end
  end
end
