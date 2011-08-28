
roles = Role.create([
  {:name => 'admin'},
  {:name => 'officer'},
  {:name => 'member'},
  {:name => 'user'}
])

admin = Role.where("name = ?", "admin").first
officer = Role.where("name = ?", "officer").first
member = Role.where("name = ?", "member").first
user = Role.where("name = ?", "user").first

users = User.create([
  {:email => 'amin@secondbureau.com', :password => 'secret', :firstname => 'Amin', :lastname => 'Rafinejad'},
  {:email => 'gilles@secondbureau.com', :password => 'secret', :firstname => 'Gilles', :lastname => 'Crofils'},
  {:email => 'johnson@secondbureau.com', :password => 'secret', :firstname => 'Johnson', :lastname => 'Zhang'},
  {:email => 'mark@secondbureau.com', :password => 'secret', :firstname => 'Mark', :lastname => 'Li'},
  {:email => 'dany@secondbureau.com', :password => 'secret', :firstname => 'Dany', :lastname => 'Yang'}
])

users[0].role = admin
users[0].firstname = "Amin"
users[0].lastname = "Rafinejad"

users[1].role = admin
users[1].firstname = "Gilles"
users[1].lastname = "Crofils"

users[2].role = officer
users[2].firstname = "Johnson"
users[2].lastname = "Zhang"

users[3].role = member
users[3].firstname = "Mark"
users[3].lastname = "Li"

users[4].role = user
users[4].firstname = "Dany"
users[4].lastname = "Yang"

users.each{|user| user.save }

pages = Page.create([
  {:title => 'About', :permalink => 'about', :content => 'some thing about about', :page_type => 'for_all'},
  {:title => 'Help', :permalink => 'help', :content => 'some thing about help', :page_type => 'for_all'}
])

content = """
Heroku is a new approach to deploying web applications. Forget about servers; the fundamental unit is the app. Develop locally on your machine just like you always do. When you’re ready to deploy, use the Heroku client gem to create your application in our cloud, then deploy with a single git push. Git allows you to have multiple source repositories all at the same time. By making Heroku just another source repository, you can push your code and deploy your application in one easy step.
Prerequisites

Before using Heroku there are three simple requirements:

   1.

      Run your Ruby application locally: Getting Started with Rails, Developing Rails apps on Mac OS X We recommend using Ruby 1.9.2 for application development. Using the Ruby Version Manager, you need only type rvm install 1.9.2 && rvm use 1.9.2 --default
   2.

      Install Git: On a Mac, Windows, or UNIX/Linux
   3.

      Create a Heroku account and install the Heroku gem

"""

10.times do |i|
  Post.create({
    :title => "Test post title #{i}",
    :content => content,
    :user => users[0],
    :post_type => "for_all",
    :can_be_subscribed => true
  })
end

10.times do |i|
  event = Event.create({
    :title => "Test Event #{i}", 
    :content => content, 
    :start_date => Time.local(20011, i + 1, 9),
    :end_date => Time.local(20011, i + 3, 9),
  })
  puts "==> #{event}"
end
