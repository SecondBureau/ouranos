namespace :mailer do
  desc "send unsent emails"
  task :send_emails => :environment do |t, args|
    Recipient.where(:sent_at => nil).each do |recipient|
      RecipientMailer.send(recipient.template, recipient).deliver
    end
    #RecipientMailer.welcome(Recipient.first).deliver
  end
end
