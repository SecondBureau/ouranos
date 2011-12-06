$s3_access_key_id         = ENV['s3_access_key_id']     || 'AKIAJW5REDYDWEQWCGTQ'
$s3_secret_access_key     = ENV['s3_secret_access_key'] || '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'
$s3_bucket                = ENV['s3_bucket']            || ENV['APP_NAME'] || 'demo-ouranos'
$ga_tracker1              = ENV['GA_TRACKER1']          || '00-123456789'
$smtp_settings            = ENV['SMTP_SETTINGS']
$google_site_verification = ENV['GOOGLE_SITE_VERIFICATION']
$available_locales        = ENV['AVAILABLE_LOCALES'].nil? ? %w[fr zh] : ENV['AVAILABLE_LOCALES'].split(',')
$init_rails_admin         = ENV['init_rails_admin'].nil? ? false : eval(ENV['init_rails_admin'])


