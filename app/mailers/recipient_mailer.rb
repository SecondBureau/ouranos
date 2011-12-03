# encoding: utf-8
class RecipientMailer < ActionMailer::Base
  
  helper :mailers

  default :from => "ape-lfip@ape-pekin.com"
  
  layout 'mailer/basic'

  def welcome(recipient)
    I18n.locale = :en
    # manadatory params
    @recipient      = recipient
    @subject        = "Bienvenue sur le Site de l'APE LFIP"
    @email_extract  = "Veuillez trouver votre mot de passe pour acceder au site de l'APE du LFIP."
    @is_archive_page = true
    # specific
    @password       = SecureRandom.hex(3)
    ActiveRecord::Base.transaction do
      recipient.update_attributes(:sent_at => Time.now, :token => SecureRandom.uuid)  
      recipient.user.update_attributes( :password => @password, :password_confirmation => @password )
      mail(:to => recipient.user.email, :subject => @subject)
    end
  end
end
