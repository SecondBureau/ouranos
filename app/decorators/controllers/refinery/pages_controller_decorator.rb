Refinery::PagesController.class_eval do
  
    include Refinery::Blog::ControllerHelper
    helper Refinery::Blog::PostsHelper
  
    before_filter :find_all_blog_posts, :only => [:home]

end