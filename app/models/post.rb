class Post < ActiveRecord::Base


  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_and_belongs_to_many :categories

  validates_presence_of :title, :content, :locale



  attr_accessor :keep_cache

  #default_scope :order => 'created_at DESC'
  scope :default_order,  :order => 'created_at DESC'
  scope :locale_posts, lambda{ |locale| where(:locale => locale) }
  #scope :top_posts, lambda{ unscoped.order("read_count desc").limit(5) }
  scope :top_posts, lambda{ unscoped.order("read_count * read_count / ((#{%w[ production demo ].include?(::Rails.env) ?  'current_date::date - created_at::date' : 'current_date - created_at' })+1) desc").limit(6) }

  def to_param
    self.permalink
  end






end
