Refinery::Calendar::Event.class_eval do
  
  # confuse with attribute excerpt
  #include ActionView::Helpers::TextHelper
  
  # for development only
  # TODO : remove !
  attr_accessible :start_at
  
  scope :coming, where("start_at >= ? or end_at >= ? ", DateTime.now, DateTime.now).order('start_at asc')
  scope :live, where("start_at is not null")
  scope :previous, where("start_at < ? and (end_at is null or end_at < ?)", DateTime.now, DateTime.now).order('start_at desc')
  
  def self.of_the_month(day=Time.now)
    Refinery::Calendar::Event.where('(start_at >= ? and start_at <= ?) or (end_at >= ? and end_at <= ?) or (start_at < ? and end_at > ?) ', day.beginning_of_month, day.end_of_month, day.beginning_of_month, day.end_of_month, day.beginning_of_month, day.end_of_month) 
  end
  
  def self.of_the_day(day=Time.now)
    Refinery::Calendar::Event.where('(start_at >= ? and start_at <= ?) or (end_at >= ? and end_at <= ?) or (start_at < ? and end_at > ?)', day.beginning_of_day, day.end_of_day, day.beginning_of_day, day.end_of_day, day.beginning_of_day, day.end_of_day) 
  end
  
  # for cache management
  def self.latest
    unscoped.order('updated_at desc').first
  end

  def etag
    updated_at.to_i
  end

end
