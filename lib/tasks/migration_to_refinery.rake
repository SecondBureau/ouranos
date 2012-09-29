task :migrate_legacy_data_to_refinery => :environment do

  #
  #Posts
  #

  # Cleaning
  Refinery::Blog::Category.all.each {|c| c.destroy}
  Refinery::Blog::Post.all.each {|p| p.destroy}

  # Categories migration
  Category.all.each do |category|
    Refinery::Blog::Category.create(:title => category.title, :description => category.description)
  end

  # Posts Migration
  Post.all.each do |post|
    p = Refinery::Blog::Post.create(:title => post.title, :body => post.content, :draft => false, :published_at => post.created_at)
    p.migrate_access_count(post.read_count)
    p.categories = Refinery::Blog::Category.where(:title => post.categories.collect(&:title))
    p.save
  end

end
