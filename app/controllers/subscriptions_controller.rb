# encoding: utf-8

class SubscriptionsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def new
    @subscription = Subscription.new(:unsubscribe => params[:unsubscribe].eql?("1"))
  end
  
  def create
    @subscription = Subscription.new(params[:subscription])
    opt_in = !@subscription.unsubscribe.eql?("1")
    current_user.update_attributes(:opt_in_newsletter => opt_in)
    redirect_to root_path, :notice => t(opt_in ? 'newsletter.opt_in' : 'newsletter.opt_out')
  end
  
end