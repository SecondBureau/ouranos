class CategoryDecorator < ApplicationDecorator
  decorates :category

  def posts
    PostDecorator.decorate(category.posts)
  end
  
end
