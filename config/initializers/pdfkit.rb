PDFKit.configure do |config|

  config.default_options[:ignore_load_errors] = true
  config.wkhtmltopdf = Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s

end 