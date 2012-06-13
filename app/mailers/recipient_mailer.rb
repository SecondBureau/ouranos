# encoding: utf-8
class RecipientMailer < ActionMailer::Base

  helper :mailers

  default :from => "smtpsender@2bu.ro"

  layout 'mailer/basic'

  def welcome(recipient)
    I18n.locale = :fr
    # manadatory params
    @recipient      = recipient
    params          = recipient.params || {}
    @title = case @recipient.user.sign_in_count
      when 0
        "Découvrez le site de l'APE !"
      when 1
        "Bienvenue sur le site de l'APE !"
      else
        "Quel plaisir de vous retrouver sur le site de l'APE !"
      end
    @email_extract  = params[:reset_password] ? "Veuillez trouver votre mot de passe pour accéder au site de l'APE du LFIP." : "Pourquoi être membre de l'APE LFIP?"
    @is_archive_page = true
    # specific
    @password       = SecureRandom.hex(3) if params[:reset_password]
    ActiveRecord::Base.transaction do
      recipient.update_attributes(:sent_at => Time.now, :token => SecureRandom.uuid)
      recipient.user.update_attributes( :password => @password, :password_confirmation => @password ) if @password
      mail(:to => recipient.user.email, :subject => @title).deliver
    end
  end


  def will_soon_expire(recipient)
    I18n.locale = :fr
    # manadatory params
    @recipient      = recipient
    @subject        = "Votre adhesion a l'APE LFIP arrive a expiration dans .. jours"
    @email_extract  = "Ci-dessous les instructions pour continuer a beneficier des avantages reserves aux membres de l'APE."
    @is_archive_page = true
    ActiveRecord::Base.transaction do
      if recipient.user
        recipient.update_attributes(:sent_at => Time.now, :token => SecureRandom.uuid)
        mail(:to => recipient.user.email, :subject => @subject).deliver
      end
    end
  end

  def newsletter(recipient)
    I18n.locale = :fr

    @recipient = recipient
    params = recipient.params || {}
    @user = recipient.user
    @user.reset_authentication_token!
    @subject = params[:subject]
    @posts = Post.find(params[:posts])
    @posts = PostDecorator.decorate(@posts)
    @events = Event.find(params[:events])
    @title = "Newsletter de l'APE LFIP"
    ActiveRecord::Base.transaction do
      recipient.update_attributes(:sent_at => Time.now, :token => SecureRandom.uuid)
      mail(:to => recipient.user.email, :subject => @subject).deliver
    end
  end

end
