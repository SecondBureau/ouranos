desc "the cron task for newsletter and membership notice"
task :cron => :environment do
  if Time.now.day == 1
    User.all.each do |user|
      newsletter = OuranosMailer.newsletter user
      newsletter.deliver
    end
  end

  User.all.each do |user|
    if user.is_of_role? :member && (user.expiry_date - Time.now)/3600/24 == 30
      membership_notice = OuranosMailer.membership_notice user
      membership_notice.deliver
    end
  end
end
