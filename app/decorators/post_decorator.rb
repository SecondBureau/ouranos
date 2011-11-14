class PostDecorator < ApplicationDecorator
  decorates :post

  def created_at
    post.created_at.strftime("%m-%d-%Y")
  end
  
  def summary
    h.raw(h.truncate(h.strip_tags(post.content), :length => 500, :omission => '...'))
  end
  
  def printer
    h.image_tag("icons/printer.png", :width => 24, :height => 24, :title => t("print.print"), :class => "print_icon", :print_path => "#{h.post_print_path(post.id)}")
  end
  
end