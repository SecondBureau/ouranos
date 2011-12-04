module MailersHelper

  def ga_link_to(*args, &block)
    if block_given?
      options      = args.first || {}
      html_options = args.second
      ga_link_to(capture(&block), options, html_options)
    else
      name         = args[0]
      options      = args[1] || {}
      html_options = args[2]

      html_options = convert_options_to_data_attributes(options, html_options)
      url = url_for(options)
      
      url += url.include?('?') ? '&' : '?'
      url += {:utm_source =>  Rails.application.config.host, :utm_medium => "email", :utm_campaign => (@recipient ? @recipient.template : '')}.to_query

      href = html_options['href']
      tag_options = tag_options(html_options)

      href_attr = "href=\"#{ERB::Util.html_escape(url)}\"" unless href
      "<a #{href_attr}#{tag_options}>#{ERB::Util.html_escape(name || url)}</a>".html_safe
    end
  end

  def converthtmlentities(string)
    puts string
    puts 'encode'
    puts HTMLEntities.new.encode(string)
    HTMLEntities.new.encode string
  end
end