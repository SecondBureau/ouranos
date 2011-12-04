# encoding: utf-8
class RecipientMailer < ActionMailer::Base
  
  helper :mailers

  default :from => "ape-lfip@ape-pekin.com"
  
  layout 'mailer/basic'

  def welcome(recipient)
    I18n.locale = :en
    # manadatory params
    @recipient      = recipient
    @subject = case @recipient.user.sign_in_count 
      when 0
        "Découvrez le site de l'APE !"
      when 1
        "Bienvenue sur le site de l'APE !"
      else
        "Quel plaisir de vous retrouver sur le site de l'APE !"
      end
    @email_extract  = "Veuillez trouver votre mot de passe pour acceder au site de l'APE du LFIP."
    @is_archive_page = true
    # specific
    @password       = SecureRandom.hex(3) if recipient.params[:reset_password]
    ActiveRecord::Base.transaction do
      recipient.update_attributes(:sent_at => Time.now, :token => SecureRandom.uuid)  
      recipient.user.update_attributes( :password => @password, :password_confirmation => @password ) if @password
      mail(:to => recipient.user.email, :subject => @subject)
    end
  end
  
  
  def will_soon_expire(recipient)
    I18n.locale = :en
    # manadatory params
    @recipient      = recipient
    @subject        = "Votre adhesion a l'APE LFIP arrive a expiration dans .. jours"
    @email_extract  = "Ci-dessous les instructions pour continuer a beneficier des avantages reserves aux membres de l'APE."
    @is_archive_page = true
    ActiveRecord::Base.transaction do
      recipient.update_attributes(:sent_at => Time.now, :token => SecureRandom.uuid)  
      mail(:to => recipient.user.email, :subject => @subject)
    end
  end

end
