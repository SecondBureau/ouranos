Refinery::Blog::PostsHelper.module_eval do 

  def blog_post_teaser(post)
    if post.respond_to?(:custom_teaser) && post.custom_teaser.present?
      post.custom_teaser.html_safe
    else
      truncate(Sanitize.clean(post.body), {
         :length => Refinery::Blog.post_teaser_length,
         :preserve_html_tags => false 
        }).html_safe
    end
  end
  
  def visible(post)
    post.public? || current_refinery_user
  end

end

