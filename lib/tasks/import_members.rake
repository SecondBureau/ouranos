namespace :db do

  desc "update emails data"
  task :update_emails_from_source => :environment do |t, args|
    i=0
    CSV.foreach("./lib/tasks/members_list.csv", encoding: "utf-8") do |row|
      i = i + 1
      next if i < 3

      firstname = row[1]
      lastname = row[0]
      email = row[5]
      print "lookup #{firstname} #{lastname}..."
      person = Person.where(:firstname => firstname, :lastname => lastname).first
      if person.nil?
        puts "NOT FOUND !"
      else
        puts "FOUND"
        if person.email.eql?(email)
          puts "Email matches ! unchanged"
        else
          person.update_attributes(:email => email)
          puts "Email updated"
        end
      end
      firstemail = email

      firstname = row[3]
      lastname = row[2]
      email = row[6]
      if firstname && lastname
        print "lookup #{firstname} #{lastname}..."
        person = Person.where(:firstname => firstname, :lastname => lastname).first
        if person.nil?
          puts "NOT FOUND !"
        else
          puts "FOUND"
          old = person.email
          if old.eql?(email)
            puts "Email matches ! unchanged"
          elsif email.blank? && old.eql?(firstemail)
            person.update_attributes(:email => nil)
            puts "no personal email (#{})"
          else
            person.update_attributes(:email => email)
            puts "Email updated #{old} => #{email}"
          end
        end
      end
    end
  end

  desc "import members data from csv"
  task :import_members_data => :environment do |t, args|
    i = 0
    CSV.foreach("./lib/tasks/members_list_test.csv", encoding: "utf-8") do |row|
      i = i + 1
      next if i < 3
      puts "name:\t #{row[0]}\t#{row[1]}"
      puts "email:\t #{row[5]}"
      role_member = Role.where("name = ?", "member").first
      tmp_password = SecureRandom.hex(16)
      puts tmp_password
      
      user = User.create({
        :email => row[5],
        :password => tmp_password,
        :password_confirmation => tmp_password,
        :role_id => role_member.id,
        :expires_at => DateTime.now + 1.year,
        :confirmed_at => DateTime.now + 5.second
      })
      user.confirmed_at = DateTime.now + 5.second
      user.save

      puts "father : #{row[0]} #{row[1]} #{row[5]}"
      father = Person.create({
        :firstname => row[0],
        :lastname => row[1],
        :email => row[5],
        :fa_type => "father"
      })

      puts "mother : #{row[2]} #{row[3]} #{row[5]}"
      mother = Person.create({
        :firstname => row[2],
        :lastname => row[3],
        :email => row[5],
        :fa_type => "mother"
      })

      kids = []
      
      j = 12
      while !row[j].nil? do
        puts "kid : #{row[j]} #{row[j+1]}"
        kid = Person.create({
          :firstname => row[j],
          :lastname => row[j+1],
          :fa_type => "kid"
        })
        kids << kid
        j += 4
      end

      family = Family.create({
        :name => "#{father.firstname} #{father.lastname} - #{mother.firstname} #{mother.lastname}"
      })
      family.user = user
      family.save()

      father.family = family
      father.save
      mother.family = family
      mother.save
      kids.each do |kid|
        kid.family = family
        kid.save
      end

      pp user.confirmed_at
      pp user.errors if user.errors.any?
      puts "=========================="
    end
  end
end
