
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

Post.create([
  {:title => "Test post title 1", :content => content, :user => users[0], :post_type => "for_all", :can_be_subscribed => true},
  {:title => "Test post title 2", :content => content, :user => users[0], :post_type => "for_all", :can_be_subscribed => true},
  {:title => "Test post title 3", :content => content, :user => users[0], :post_type => "for_all", :can_be_subscribed => true},
  {:title => "Test post title 4", :content => content, :user => users[0], :post_type => "for_all", :can_be_subscribed => true},
  {:title => "Test post title 5", :content => content, :user => users[0], :post_type => "for_all", :can_be_subscribed => true},
  {:title => "Test post title 6", :content => content, :user => users[0], :post_type => "for_all", :can_be_subscribed => true},
  {:title => "Test post title 7", :content => content, :user => users[0], :post_type => "for_all", :can_be_subscribed => true},
  {:title => "Test post title 8", :content => content, :user => users[0], :post_type => "for_all", :can_be_subscribed => true},
  {:title => "Test post title 9", :content => content, :user => users[0], :post_type => "for_all", :can_be_subscribed => true},
])

events = Event.create([
  {:title => "Test Event 1", :content => content, :start_date => Time.local(20011, 9, 1),:end_date => Time.local(20011, 9, 2)},
  {:title => "Test Event 2", :content => content, :start_date => Time.local(20011, 9, 10),:end_date => Time.local(20011, 9, 20)},
  {:title => "Test Event 3", :content => content, :start_date => Time.local(20011, 9, 21),:end_date => Time.local(20011, 9, 25)},
  {:title => "Test Event 4", :content => content, :start_date => Time.local(20011, 10, 1),:end_date => Time.local(20011, 10, 2)},
  {:title => "Test Event 5", :content => content, :start_date => Time.local(20011, 10, 1),:end_date => Time.local(20011, 10, 12)},
  {:title => "Test Event 6", :content => content, :start_date => Time.local(20011, 10, 1),:end_date => Time.local(20011, 10, 22)},
  {:title => "Test Event 7", :content => content, :start_date => Time.local(20011, 10, 1),:end_date => Time.local(20011, 11, 12)},
  {:title => "Test Event 8", :content => content, :start_date => Time.local(20011, 11, 1),:end_date => Time.local(20011, 11, 8)},
  {:title => "Test Event 9", :content => content, :start_date => Time.local(20011, 11, 1),:end_date => Time.local(20011, 11, 22)},
  {:title => "Test Event 10", :content => content, :start_date => Time.local(20011, 12, 1),:end_date => Time.local(20011, 12, 2)}
])
