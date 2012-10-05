# encoding: utf-8

task :migrate_legacy_data_to_refinery => :environment do
  
  I18n.locale = :fr

  include ActionView::Helpers::TextHelper
  
  
  #
  #Posts
  #

  # Cleaning
  Refinery::Blog::Category.all.each {|c| c.destroy}
  Refinery::Blog::Post.all.each {|p| p.destroy}
  (1..3).each do |i|
    begin
      Refinery::Page.all.each {|p| p.destroy!}
    rescue
    end
  end
  Refinery::Calendar::Event.all.each {|e| e.destroy}


  # Categories migration
  Category.all.each do |category|
    Refinery::Blog::Category.create(:title => category.title, :description => category.description)
  end

  # Posts Migration
  Post.all.each do |post|
    p = Refinery::Blog::Post.create(:title => post.title, :body => post.content, :draft => false, :public => false, :published_at => post.created_at)
    p.migrate_access_count(post.read_count)
    p.categories = Refinery::Blog::Category.where(:title => post.categories.collect(&:title))
    p.save
  end

  # Pages Migration


  home_page = Refinery::Page.create!({
              :title => "Edito",
              :show_in_menu => false,
              :deletable => false,
              :link_url => "/",
              :menu_match => "^/$"})
  home_page.parts.create({
                :title => "Body",
                :body => "<p>L'Edito du Président.</p>",
                :position => 0
              })
  home_page.parts.create({
                :title => "Side Body",
                :body => "<p>Bienvenue sur votre nouveau site.</p>",
                :position => 1
              })

  home_page_position = -1

  page_not_found_page = home_page.children.create(:title => "Erreur 404!",
              :menu_match => "^/404$",
              :show_in_menu => false,
              :deletable => false)
  page_not_found_page.parts.create({
                :title => "Body",
                :body => "<h2>Oups, petit problème...</h2><img src='/assets/404.jpg'><p>Il n'y a rien par ici.</p><p><a href='/'>Retournons à l'accueil</a></p>",
                :position => 0
              })

  page_contact_page = home_page.children.create(:title => "Contact",
              :menu_match => "^/contact$",
              :show_in_menu => false,
              :deletable => false)
  page_contact_page.parts.create({
                :title => "Body",
                :body => "Page non visible.",
                :position => 2
              })
  page_contact_page.parts.create({
                :title => "Home",
                :body => "<p>contact@ape-pekin.com<br/>Boite aux lettres dans le hall du bâtiment A du site principal.</p>",
                :position => 0
              })

  page_contact_page.parts.create({
                :title => "Join Us",
                :body => "<p>L’APE est une association de parents bénévoles qui donnent leur temps pour défendre les intérêts de tous les enfants du LFIP et de leurs familles. </p>\r\n<p>Rejoignez-nous et accédez à l'intégralité des articles. <a title=\"Comment adhérer\" href=\"/comment-adherer\">Cliquez ici pour connaitre tous les avantages réservés aux membres</a>.</p>",
                :position => 1
              })

  page_blog = Refinery::Page.create!({
                :title => "Articles",
                :link_url => "/blog",
                :deletable => false,
                :menu_match => "^/blogs?(\/|\/.+?|)$"
              })


  Refinery::Pages.default_parts.each do |default_page_part|
    page_blog.parts.create(:title => default_page_part, :body => nil)
  end


  url = "/calendar/events"

  page_calendar = ::Refinery::Page.create(
                  :title => 'Evénements',
                  :link_url => url,
                  :deletable => false,
                  :menu_match => "^#{url}(\/|\/.+?|)$"
                )

  page_calendar.parts.create({
                :title => "Body",
                :body => "Les événéments organisés par l'APE",
                :position => 0
              })
  page_calendar.parts.create({
                :title => "Side Body",
                :body => "Page non visible",
                :position => 0
              })
    Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
      page_calendar.parts.create(:title => default_page_part, :body => nil, :position => index)
    end 

  Page.all.each do |page|
    refinery_page = Refinery::Page.create(:title => page.title, :show_in_menu => true)
    refinery_page.parts.create(:title => "Body", :body => page.content, :position => 0)
  end

  # events

  Event.all.each do |event|
    Refinery::Calendar::Event.create(:title => event.title, :start_at => event.start_date, :end_at => event.end_date, :excerpt => truncate(Sanitize.clean(event.content), :length => 50, :omission => '...'), :description => event.content)
  end

  

 
  # Users, Roles & Groups
  Refinery::User.all.each do |u| 
    u.bypass_mailchimp = true
    u.destroy
  end
  Refinery::Role.all.each {|r| r.destroy }
  Refinery::Groups::Group.all.each {|g| g.destroy }
  
  # Roles
  %w[Refinery Superuser Member Group_Admin].each {|r| Refinery::Role.[](r.downcase.to_sym)}
  
  
  # Default groups
  guestsGroup = Refinery::Groups::Group.create!(:name => 'guest', :expiration_date => Time.parse('20000101'), :description => 'Individuels abonnés à la newsletter, mais sans accès au site.')
  membersGroup = Refinery::Groups::Group.create!(:name => 'Members', :expiration_date => Time.parse('20991231'), :description => 'Individuels abonnés à la newsletter avec un accès permanent au site.')
  
  # SuperAdmin
  admin = Refinery::User.new(:username => 'secondbureau', :password => 'secret', :password_confirmation => 'secret', :firstname => 'Gilles', :lastname => 'Crofils', :email => 'ape-lfip@secondbureau.com')
  admin.group = membersGroup
  admin.bypass_mailchimp = true
  admin.roles = ['Refinery', 'Superuser'].collect { |r| Refinery::Role[r.downcase.to_sym] }
  admin.save! # we need to save it first.
  admin.plugins = Refinery::Plugins.registered.collect(&:name)
  
  
  
  guestid = 0
  
  Family.all.each do |family|
    
    unless (user = family.user).nil?
      group = Refinery::Groups::Group.create(:name => family.name.strip, :expiration_date => user.expires_at)
      
      password = 'secret'
      groupAdmin = Refinery::User.new(
        :username => user.email, 
        :password => password, 
        :password_confirmation => password, 
        :email => user.email, 
        :current_sign_in_at => user.current_sign_in_at, 
        :last_sign_in_at => user.last_sign_in_at,
        :current_sign_in_ip => user.current_sign_in_ip, 
        :last_sign_in_ip => user.last_sign_in_ip, 
        :sign_in_count => user.sign_in_count)
      groupAdmin.group = group
      groupAdmin.bypass_mailchimp = true
      groupAdmin.roles = ['Refinery', 'Group_Admin'].collect { |r| Refinery::Role[r.downcase.to_sym] }  
      groupAdmin.save! # we need to save it first.
      groupAdmin.plugins = ['groups']
      
    end
    
    family.people.each do |person|

      begin
      password = 'secret'
      
      firstname = person.firstname.parameterize rescue nil
      lastname = person.lastname.parameterize rescue nil
      username = [firstname, lastname].compact.join('.')
      
      if username.eql?('')
        guestid += 1
        username = "guest_#{guestid}"
        puts "****** #{username} *******"
      end
      
      email = person.email || "#{username}@example.org"
      
      refinery_user = Refinery::User.find_by_email(person.email) unless person.email.nil?
      refinery_user = Refinery::User.new if refinery_user.nil?
      refinery_user.add_role(:refinery)
      refinery_user.group = group
      refinery_user.bypass_mailchimp = true
      refinery_user.update_attributes!(:username => username, :password => password, :password_confirmation => password, :firstname => person.firstname, :lastname => person.lastname, :email => email, :position => person.fa_type, :position_updated_at => person.updated_at, :optin_newsletter => !person.email.nil?)
      
    rescue Exception => e
      puts "===== ERREUR == #{e}"
      puts family.inspect
      puts person.inspect
    end

      
    end
    
  end


end
