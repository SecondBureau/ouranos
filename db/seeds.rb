
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
