class SubscribesController < ApplicationController
  
  layout "newsletter", :only => [:show]
  
  def index
    @posts_options = {
      5 => 5,
      10 => 10,
      15 => 15,
      20 => 20,
      25 => 25,
      30 => 30,
      35 => 35
    }
    @events_options = {
      5 => 5,
      10 => 10,
      15 => 15
    }
    @cycle_options = {
      1 => 1,
      2 => 2,
      3 => 3,
      4 => 4,
      5 => 5,
      6 => 6,
      7 => 7
    }
    @display = user_signed_in?? "block":"none";
  end
  
  def show
    newsletter = Newsletter.newsletter(current_user)
    newsletter.deliver
  end

end
