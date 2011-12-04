namespace :db do
  namespace :users do
    desc "send password to all members who have never connected"
    task :mass_init_password => :environment do |t, args|
      User.where(:sign_in_count => 0).each  {|user| Recipient.create(:user => user, :template => 'welcome', :params => {:reset_password => true}) }
    end
  end
end
