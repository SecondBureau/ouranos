Refinery::Calendar::Event.class_eval do
  
  # confuse with attribute excerpt
  #include ActionView::Helpers::TextHelper
  
  scope :coming, lambda{ where("start_at >= ? or end_at >= ? ", DateTime.now, DateTime.now).order('start_at asc').limit(5) }
  
  def self.of_the_month(day=Time.now)
    Refinery::Calendar::Event.where('(start_at >= ? and start_at <= ?) or (end_at >= ? and end_at <= ?) or (start_at < ? and end_at > ?) ', day.beginning_of_month, day.end_of_month, day.beginning_of_month, day.end_of_month, day.beginning_of_month, day.end_of_month) 
  end
  
  def self.of_the_day(day=Time.now)
    Refinery::Calendar::Event.where('(start_at >= ? and start_at <= ?) or (end_at >= ? and end_at <= ?) or (start_at < ? and end_at > ?)', day.beginning_of_day, day.end_of_day, day.beginning_of_day, day.end_of_day, day.beginning_of_day, day.end_of_day) 
  end

end
