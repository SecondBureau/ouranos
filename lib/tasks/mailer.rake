namespace :mailer do
  desc "send unsent emails"
  task :send_emails => :environment do |t, args|
    Recipient.where(:sent_at => nil).each_with_index do |recipient, index|
      RecipientMailer.send(recipient.template, recipient)
      break unless index < 4 || Rails.env.production?
    end
  end
end
