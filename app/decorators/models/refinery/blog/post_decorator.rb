Refinery::Blog::Post.class_eval do

  def migrate_access_count(count)
    self.access_count = count
  end

end
