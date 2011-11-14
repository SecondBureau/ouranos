class PostDecorator < ApplicationDecorator
  decorates :post

  def created_at
    post.created_at.strftime("%m-%d-%Y")
  end
  
  def printer
    h.image_tag("icons/printer.png", :width => 24, :height => 24, :title => t("print.print"), :class => "print_icon", :print_path => "#{h.post_print_path(post.id)}")
  end
  
end
