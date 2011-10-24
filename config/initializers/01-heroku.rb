$s3_access_key_id         = ENV['s3_access_key_id']     || 'AKIAI76TH2YOZJ6U4APA'
$s3_secret_access_key     = ENV['s3_secret_access_key'] || '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'
$s3_bucket                = ENV['s3_paperclip_bucket']  || "demo-ouranos"
$available_locales        = ENV['AVAILABLE_LOCALES'].nil? ? %w[fr zh] : ENV['AVAILABLE_LOCALES'].split(',')
$init_rails_admin         = ENV['init_rails_admin']  || false

