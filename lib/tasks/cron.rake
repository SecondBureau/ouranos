namespace :cron do
  desc "send emails"
  task :send_emails => :environment do
    Rake::Task['mailer:send_emails'].invoke
  end
  desc "prepare newsletter"
  task :prepare_newsletter => :environment do
    Rake::Task['mailer:prepare_newsletter'].invoke
  end
end
