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
    p = Refinery::Blog::Post.create(:title => post.title, :body => post.content, :draft => false, :published_at => post.created_at)
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
  
  # Groups
  Refinery::Role.all.each {|r| r.destroy }
  %w[Refinery Superuser Member GroupAdmin].each {|r| Refinery::Role.[](r)}
  
  


end
