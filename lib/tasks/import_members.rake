namespace :db do

  desc "import members data from csv"
  task :import_members_data => :environment do |t, args|
    CSV.foreach("./lib/tasks/members_list.csv") do |row|
      puts "name:\t #{row[0]}\t#{row[1]}"
      puts "email:\t #{row[5]}"
      puts "=========================="
      member = Role.where("name = ?", "member").first
      user = User.create(
        :firstname => row[0],
        :lastname => row[1],
        :email => row[5],
        :password => 'secret',
        :password_confirmation => 'secret',
        :role_id => member.id,
        :is_expiried => false,
        :expiry_date => DateTime.now + 1.year
      )
      pp user.errors if user.errors.any?
    end
  end
end
