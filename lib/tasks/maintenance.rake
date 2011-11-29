namespace :db do
  namespace :users do
    desc "send password to all members who have never connected"
    task :mass_init_password => :environment do |t, args|
      User.where(:sign_in_count => 0).each do |user|
        tmp_password = SecureRandom.hex(16)
        ActiveRecord::Base.transaction do
          user.update_attributes( :password => tmp_password, :password_confirmation => tmp_password )
          OuranosMailer.membership_welcome(user).deliver
        end
      end
    end
  end
end
