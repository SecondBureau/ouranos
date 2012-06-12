namespace :mailer do
  desc "send unsent emails"
  task :send_emails => :environment do |t, args|
    Recipient.where(:sent_at => nil).each do |recipient|
      RecipientMailer.send(recipient.template, recipient)
    end
  end
end
