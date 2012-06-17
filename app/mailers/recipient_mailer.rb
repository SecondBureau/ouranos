# encoding: utf-8
class RecipientMailer < ActionMailer::Base

  helper :mailers

  default :from => "APE LFIP <#{$noreply_sender}>"

  layout 'mailer/basic'

  def welcome(recipient)
    I18n.locale = :fr
    # mandatory params
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
    # mandatory params
    @recipient      = recipient
    @subject        = "Votre adhesion a l'APE LFIP arrive a expiration dans #{(Time.now - recipient.user.expires_at - Time.now).to_i / 60 / 60 / 24} jours" unless recipient.user.expires_at.nil?
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
    I18n.locale   = :fr
    @recipient    = recipient
    @user         = recipient.user
    @user.reset_authentication_token!
    subject   = "#{t('newsletter.subject')} [#{I18n.l(DateTime.now, :format => "%B %Y")}]" 
    @title = t 'newsletter.subject'
    @email_extract  = "Les actualités de votre association ce mois ci."
    @unsubscribe_link = true
    params    = recipient.params || {}
    @posts            = PostDecorator.decorate(Post.order('updated_at desc').find(params[:posts_ids]))
    @previous_events  = Event.find(params[:previous_events_ids])  
    @next_events      = Event.find(params[:next_events_ids]) 
    ActiveRecord::Base.transaction do
      if recipient.user 
        recipient.update_attributes(:sent_at => Time.now, :token => SecureRandom.uuid)
        mail(:to => recipient.user.email, :subject => subject).deliver
        recipient.user.update_attributes(:newsletter_sent_at => DateTime.now)
      end
    end
  end

end
