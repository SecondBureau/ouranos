desc "the cron task for newsletter and membership notice"
task :cron => :environment do
  if Time.now.day == 1
    # send news letter
  end

  if Time.now.hour == 0
    User.all.each do |user|
      #check membership expiry date and send email
    end
  end
end