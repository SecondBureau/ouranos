$s3_access_key_id         = ENV['s3_access_key_id']     || 'AKIAI76TH2YOZJ6U4APA'
$s3_secret_access_key     = ENV['s3_secret_access_key'] || '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'
$s3_bucket                = ENV['s3_bucket']            || "#{ENV['RACK_ENV']}-#{ENV['APP_NAME']}"
$ga_tracker1              = ENV['GA_TRACKER1']          || '00-123456789'
$smtp_settings            = ENV['SMTP_SETTINGS']
$google_site_verification = ENV['GOOGLE_SITE_VERIFICATION']
$available_locales        = ENV['AVAILABLE_LOCALES'].nil? ? %w[fr zh] : ENV['AVAILABLE_LOCALES'].split(',')

