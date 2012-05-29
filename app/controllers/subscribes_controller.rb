class SubscribesController < ApplicationController

  before_filter :authenticate_user!, :is_membership_expired?

  def index
    @display = user_signed_in?? "block":"none";
    @subscribe = Subscribe.new
    render :layout => "application"
  end

  def show
    @posts = Post.default_order.limit(5)
    @events = Event.limit(5)
    newsletter = OuranosMailer.newsletter(current_user, @posts, @events)
    newsletter.deliver
    @date = Time.now.strftime("%m/%d/%Y")
    render :layout => "newsletter", :template => "ouranos_mailer/newsletter"
  end

  def create
    subscribe = Subscribe.create params[:subscribe]
    @posts = Post.default_order.limit(subscribe.num_of_posts)
    @events = Event.limit(subscribe.num_of_events)
    binding.pry
    newsletter = OuranosMailer.newsletter(current_user, @posts, @events)
    newsletter.deliver
    redirect_to subscribes_path, :notice => "Create subscribe successfully!"
  end

end

