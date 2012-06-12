# encoding: utf-8
class String
  def clean
    acc = "ÀÁÂÃÄÅÇÑñÇçÈÉÊËÌÍÎÏÒÓÔÕÖØÙÚÛÜÝàáâãäåçèéêëìíîïðòóôõöøùúûüýÿ"
    self.force_encoding("UTF-8").tr(acc,'_').downcase
  end
end

class ApplicationController < ActionController::Base

  require 'daryl'

  protect_from_forgery

  before_filter :set_locale
  before_filter :set_ga_custom_value, :set_ga_custom_name

  helper_method :available_locales, :current_locale

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, :alert => exception.message
  end

  def is_membership_expired?
    redirect_to(main_app.root_path) if (!current_user || current_user.is_expired?)
  end

  def check_member_confirmation

  end

  def unsubscribe
    if user_signed_in?
      user = User.find(:first, :conditions => ["lower(email) LIKE ?", params[:id].downcase])
      if user
        user.newsletter = false
        user.save!
        @email = params[:id]
      else
        redirect_to '/'
      end
    else
      redirect_to '/'
    end
  end

	def import
	  if user_signed_in?
  	  :import
  	else
  	  redirect_to '/admin'
  	end
	end





	def read_import
    file = params[:file]
	  @all = []
	  @families = []
	  people_ids = []
	  family_ids = []
	  user_ids = []
	  i=0
    CSV.foreach file.tempfile do |row|
      i = i + 1
      next if i < 3

      family_name = row[0]
      family_name = family_name + " "+row[1] if row[1]
			family = Family.find(:first, :conditions => ["lower(name) LIKE ?", family_name.clean])

			if family
			  family_ids << family.id
			elsif
			  family = Family.new({:name => family_name})
			end

			unless ::Rails.env.eql?('production')
			  email_test = "#{row[5].gsub('@romain.2bu.ro','').gsub('@','.')}@romain.2bu.ro"
			end
			user = User.find(:first, :conditions => ["lower(email) LIKE ?", email_test])
			if user
			  user_ids << user.id
		  	family.user = user
		  elsif
		    family.user = User.new({:email => row[5]})
		  end


			if row[0] && row[1]
			  father = find(row[0], row[1])
			  if father
			    people_ids << father.id
			    family.people << father
			  elsif
          family.people.build({:firstname => row[1],:lastname => row[0],:email => row[6],:fa_type => "father"})
        end
      end

      mother = find(row[2], row[3])

      if row[2] && row[3]
        mother = find(row[2], row[3])
        if mother
          people_ids << mother.id
          family.people << mother
        elsif
          family.people.build({:firstname => row[3],:lastname => row[2],:email => row[7],:fa_type => "mother"})
        end
      end

      j = 12
      while !row[j].nil? do
        kid = find(row[j], row[j+1])
        if kid
          people_ids << kid.id
          family.people << kid
        elsif
          family.people.build({:firstname => row[j+1],:lastname => row[j],:fa_type => "kid"})
        end

        j += 4
      end

      @families << family

      session[:families] = @families

      # People in database but not in the file
      if people_ids.count > 0
        @missing_people = Person.where("id NOT IN (?)", people_ids)
      else
        @missing_people = Person.all
      end

      role_member = Role.where("name = ?", "member").first
      if user_ids.count > 0
        @missing_users = User.where("id NOT IN (?) AND role_id = ?", user_ids, role_member.id)
      else
        @missing_users = User.where("role_id = ?", role_member.id)
      end

      if family_ids.count > 0
        @missing_families = Family.where("id NOT IN (?)", family_ids)
      else
        @missing_families = Family.all
      end
    end
  end

  def find(lastname, firstname)
    acc = "ÀÁÂÃÄÅÇÑñÇçÈÉÊËÌÍÎÏÒÓÔÕÖØÙÚÛÜÝàáâãäåçèéêëìíîïðòóôõöøùúûüýÿ"
    if lastname && firstname
      person = Person.find(:first, :conditions => ["lower(firstname) LIKE ? AND lower(lastname) LIKE ?", firstname.clean, lastname.clean])
    end
  end

	def do_import
	  begin
		  # Add of the new members
		  session[:families].each do |family|
        if !family.id || !family.user.id
          tmp_password = SecureRandom.hex(16)
          role_member = Role.where("name = ?", "member").first
          email = family.user.email
          if !family.user.id
            user = User.create({
              :email => email,
              :password => tmp_password,
              :password_confirmation => tmp_password,
              :role_id => role_member.id,
    		      :expires_at => DateTime.now + 1.year,
              :confirmed_at => DateTime.now + 5.second
            })
            user.confirmed_at = DateTime.now + 5.second
            user.save
            family.user = user
          end
        end

		    if params[:add][family.name]
		      index = 0
		      family.people.each do |person|
		        if params[:add][family.name].index(index.to_s)
		          person.family = family
		          person.save!
		        end
		        index += 1
		      end
		    end
        family.save
		  end
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
	  end

	  begin
	    Person.delete(params[:delete_people])
	    Family.delete(params[:delete_families])
	    User.delete(params[:delete_users])
	  rescue Exception
	  end

	  redirect_to '/'
	end

  private
    def default_url_options(options={})
      {:locale => I18n.locale }
    end

    def current_locale
      params[:locale] || I18n.locale
    end

    def available_locales
      $available_locales || ["fr"]
    end

    def set_locale
      I18n.locale = params[:locale] if available_locales.include?(params[:locale])
      I18n.locale = available_locales.first unless available_locales.include?(I18n.locale.to_s)
    end


    def anonymous_id
      session[:anonymous_id] ||= (10000 + rand(100000))
    end

    def compound_metric_name
      'page_view'
    end

    def restful_metrics_application_identifier
      'app1531543'
    end

    def count_static_page
      begin
        RestfulMetrics::Client.add_compound_metric(restful_metrics_application_identifier, compound_metric_name, 'info', current_user ? current_user.id : anonymous_id) if $restful_metrics_api_key
      rescue
      end
    end

    def count_post_page
      begin
      RestfulMetrics::Client.add_compound_metric(restful_metrics_application_identifier, compound_metric_name, 'post') if $restful_metrics_api_key
      rescue
      end
    end

    def count_event_page
      begin
      RestfulMetrics::Client.add_compound_metric(restful_metrics_application_identifier, compound_metric_name, 'event') if $restful_metrics_api_key
      rescue
      end
    end

    def ga_custom
      @ga_custom ||= {}
    end

    def set_ga_custom_name
      ga_custom[:name] = 'section'
    end

  def set_ga_custom_value
    ga_custom[:value] = 'other'
  end

end
