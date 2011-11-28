desc "send all members an email for the website has started"
task :send_start_email_to_members => :environment do
  User.all.each do |user|
    if user.is_of_role? :member && (user.expiry_date - Time.now)/3600/24 == 30
      #OuranosMailer.membership_notice user.deliver
    end
  end

end

