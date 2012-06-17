namespace :newsletter do
  
  desc "prepare newsletter"
  task :prepare => :environment do |t, args|
    
    User.where(:opt_in_newsletter => true).where('newsletter_sent_at is null or newsletter_sent_at < ?', Time.now - eval($newsletter_period)).each do |user|
      last_sent_at  = user.newsletter_sent_at || user.created_at
      posts_ids     = Post.order('updated_at desc').where('created_at > ?', last_sent_at).collect(&:id)
      previous_events_ids    = Event.order('start_date desc').where('start_date > ? and start_date < ?', last_sent_at, Time.now).collect(&:id)
      next_events_ids        = Event.order('start_date desc').where('start_date > ?', Time.now).collect(&:id)
      Recipient.create(:user => user, :template => 'newsletter', :params => {:posts_ids => posts_ids, :previous_events_ids => previous_events_ids, :next_events_ids => next_events_ids}) unless posts_ids.empty? && previous_events_ids.empty? && next_events_ids.empty?
    end
    
  end

end