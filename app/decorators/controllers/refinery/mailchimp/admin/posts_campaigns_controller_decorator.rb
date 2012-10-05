Refinery::Mailchimp::Admin::PostsCampaignsController.class_eval do
  
  protected

    def set_campaign_body
      if params[:posts_campaign][:nltype] == "1"
        @edition = Refinery::Blog::Edition.find params[:posts_campaign][:edito_id]
        @posts = @edition.content_posts
        @edito = @edition.edito
        @categories_posts = @posts.to_a.group_by{|post| post.categories.first.title }
        body_html = render_to_string(:partial => "weekly_newsletter")
      elsif params[:posts_campaign][:nltype] == "2"
        @edito = Refinery::Blog::Post.find params[:posts_campaign][:edito_id]
        body_html = render_to_string(:partial => "free_edito_newsletter")
      elsif params[:posts_campaign][:nltype] == "3"
        posts_ids = params[:posts_campaign][:posts].split(",")
        @posts = Refinery::Blog::Post.where(:id => posts_ids)
        params[:posts_campaign][:posts] = posts_ids
        @categories_posts = @posts.to_a.group_by{|post| post.categories.any? ? post.categories.first.title : 'DEFAULT_CATEGORY' }  #BUGFIX
        body_html = render_to_string(:partial => "free_posts_newsletter")
      end
      params[:posts_campaign][:body] = body_html
    end
  
  
  
end