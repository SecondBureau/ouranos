ActionMailer::Base.smtp_settings = JSON.parse($smtp_settings).symbolize_keys unless $smtp_settings.nil?


