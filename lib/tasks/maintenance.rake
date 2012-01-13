# encoding: utf-8
namespace :db do
  namespace :users do
    desc "send password to all members who have never connected"
    task :mass_init_password => :environment do |t, args|
      User.where(:sign_in_count => 0).each  {|user| Recipient.create(:user => user, :template => 'welcome', :params => {:reset_password => true}) }
    end
  end
  namespace :people do
    desc "export People information for mailing"
    task :export => :environment do |t, args|
      puts "db.people.export : retrieve #{Person.count} rows ..."
      rows = ['firstname','lastname','position','email','dernière connexion','login','expiration'].join(sep)
      errors = []
      sep = ";"
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
        rows << [p.firstname, p.lastname, p.fa_type, p.email, u.current_sign_in_at, u.email, u.expires_at].join(sep)
      end

      name = "#{ENV['APP_NAME']}-people-#{Time.now.strftime('%Y-%m-%d-%H%M%S')}.csv"
      puts "db.people.export : write document..."
      File.open("tmp/#{name}", 'w') {|f| f.write(rows.join("\n")) }
      File.open("tmp/#{name}", 'a') {|f| f.write(errors.join("\n")) } if errors.count > 0
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
