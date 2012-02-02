class Post < ActiveRecord::Base

  require 'lipsum'

  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_and_belongs_to_many :categories

  validates_presence_of :title, :content, :locale

  before_save :lipsum
  after_save :set_permalink, :expire_cache
  
  attr_accessor :keep_cache 

  #default_scope :order => 'created_at DESC'
  scope :default_order,  :order => 'created_at DESC' 
  scope :locale_posts, lambda{ |locale| where(:locale => locale) }
  #scope :top_posts, lambda{ unscoped.order("read_count desc").limit(5) }
  scope :top_posts, lambda{ unscoped.order("read_count * read_count / ((#{%w[ production demo ].include?(::Rails.env) ?  'current_date::date - created_at::date' : 'current_date - created_at' })+1) desc").limit(6) }

  def to_param
    self.permalink
  end

  private

    def set_permalink
      if self.permalink.nil?
        self.permalink = "#{self.title.parameterize}-#{self.id}"
        self.save
      end
    end

    def lipsum
      self.content  = Lipsum.generate(:words => 100 + rand(5), :start_with_lipsum => false) if self.content.eql?'lipsum'
      self.title    = Lipsum.generate(:words => 3 + rand(5), :start_with_lipsum => false) if self.title.eql?'lipsum'
      self.meta_description    = Lipsum.generate(:characters => 150 + rand(50), :start_with_lipsum => false) if self.meta_description.eql?'lipsum'
      self.meta_keywords    = Lipsum.generate(:words => 20 + rand(5), :start_with_lipsum => false).gsub('.','').gsub(',','').split(' ').join(', ') if self.meta_keywords.eql?'lipsum'
    end
    
    def expire_cache
      unless self.keep_cache
        $available_locales.each do |locale|
          Rails.cache.delete "views/pinned_posts_#{locale}" # if self.is_pinned
          Rails.cache.delete "views/latest_posts_#{locale}"
          day = (Time.now.utc.in_time_zone("Beijing")).strftime("%Y%m%d")
          %w[ header sidebar ].each {|page| Rails.cache.delete "views/#{page}_#{locale}_#{day}"}
        end
        %w[ admin member ].each {|role| Rails.cache.delete "views/post_#{self.locale}_#{self.id}_#{role}"}
      end
    end
    
    def save_without_expiring_cache
      self.keep_cache = true
      save
    end

end
