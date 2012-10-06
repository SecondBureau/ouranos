# encoding: utf-8

Refinery::Mailchimp::Admin::PostsCampaignsController.class_eval do
  
  helper Refinery::Blog::PostsHelper
  
  protected

    def set_campaign_body
      posts_ids = params[:posts_campaign][:posts].split(",")      
      @edito = Refinery::Page.edito
      @posts = Refinery::Blog::Post.where(:id => posts_ids)      
      body_posts = render_to_string(:partial => "newsletter_posts")
      body_edito = render_to_string(:partial => "newsletter_edito")
      preheader_content = "Votre lettre d'information de l'association des parents d'élèves."
      params[:posts_campaign][:posts] = posts_ids
      params[:posts_campaign][:body]  = {:html_preheader_content => preheader_content, :html_body_edito => body_edito, :html_body_posts => body_posts}
    end
    
  
  
  
end