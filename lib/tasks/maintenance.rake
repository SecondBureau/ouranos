# encoding: utf-8
namespace :db do
  namespace :users do
    desc "send password to all members who have never connected"
    task :mass_init_password => :environment do |t, args|
      User.where(:sign_in_count => 0).each  {|user| Recipient.create(:user => user, :template => 'welcome', :params => {:reset_password => true}) }
    end
  end

  namespace :family do
    desc "rename famillies"
    task :rename_families  => :environment do |t, args|
      Family.all.each do |family|
        father = family.people.select{|p| p.fa_type.eql?('father')}.first
        mother = family.people.select{|p| p.fa_type.eql?('mother')}.first
        if father.nil? && mother.nil?
          puts "No mother, no father in the family #{family.name}"
          next
        end
        familyname = ''
        familyname = father.lastname unless father.nil?
        fullname = []
        fullname << "#{familyname} #{father.firstname}" unless father.nil?
        mother_lastname = mother.nil? ? "" : "#{mother.lastname} "
        fullname << "#{mother.lastname.eql?(familyname) ? '' : mother_lastname}#{mother.firstname}" unless mother.nil?
        family.update_attributes(:name => fullname.join(' - '))
      end
    end
  end

  namespace :people do
    desc "set login email to 1 person by family if no one is set"
    task :update_email_from_account => :environment do |t, args|
      Family.all.each do |family|
        print "#{family.name}"
        if family.people.reject{|p| p.email.nil?}.count.eql?(0)
          puts " has no default email"
          person = family.people.select{|p| p.fa_type.eql?('father')}.first
          person = family.people.select{|p| p.fa_type.eql?('mother')}.first if person.nil?
          if person.nil?
            puts "No mother, no father in the family #{family.name}"
            next
          end
          person.update_attributes(:email => family.user.email)
          puts "updated #{person.firstname} #{person.lastname} with email #{person.email}"
        else
          puts " has #{family.people.reject{|p| p.email.nil?}.collect{|p| p.email}.join(', ')} for email(s)"
        end
      end
    end


    desc "export People information for mailing"
    task :export => :environment do |t, args|
      sep = ";"
      puts "db.people.export : retrieving #{Person.count} rows ..."
      rows = [['Family', 'firstname','lastname','position','email','dernière connexion','login','expiration'].join(sep)]
      errors = []
      Person.all.each do |p|
        f = p.family
        if f.nil?
          errors << "Person #{p.id} (#{p.firstname},#{p.lastname},#{p.fa_type}) has no family"
          next
        end
        u = f.user
        if u.nil?
          errors << "Family #{f.id} has no user"
          next
        end
        rows << [f.name, p.firstname, p.lastname, p.fa_type, p.email, u.current_sign_in_at, u.email, u.expires_at].join(sep)
      end

      name = "#{ENV['APP_NAME']}-people-#{Time.now.strftime('%Y-%m-%d-%H%M%S')}.csv"
      puts "db.people.export : write document..."
      File.open("tmp/#{name}", 'w') {|f| f.write(rows.join("\n")) }
      File.open("tmp/#{name}", 'a') {|f| f.write("\n\nERRORS\n#{errors.join("\n")}") } if errors.count > 0
      puts "db.people.export : starting gzip process..."
      system "tar cvf - tmp/#{name} | gzip -9c > tmp/#{name}.tar.gz"
      puts "db.people.export : Temp file gzipped"
      s3 = RightAws::S3.new(ENV['s3_access_key_id'], ENV['s3_secret_access_key'])
      bucket = s3.bucket("#{ENV['APP_NAME']}-heroku-data", true, 'private')
      bucket.put("#{name}.tar.gz", open("tmp/#{name}.tar.gz"))
      system "rm tmp/#{name}"
      system "rm tmp/#{name}.tar.gz"
      puts "db.people.export : Process finished"
    end
  end
end
