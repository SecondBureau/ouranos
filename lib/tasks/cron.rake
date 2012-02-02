desc "the cron task for newsletter and membership notice"
task :cron => :environment do
  #if Time.now.day == 1
    #User.all.each do |user|
      #newsletter = OuranosMailer.newsletter user
      #newsletter.deliver
    #end
  #end


  #User.all.each do |user|
   # if user.is_of_role? :member && (user.expires_at - Time.now)/3600/24 == 30
      #OuranosMailer.membership_notice user.deliver
    #end
  #end
  $available_locales.each do |locale|
    day = (Time.now.utc.in_time_zone("Beijing") - 24*60*60 ).strftime("%Y%m%d")
    %w[ header sidebar ].each {|page| Rails.cache.delete "views/#{page}_#{locale}_#{day}"}
  end
  
end

