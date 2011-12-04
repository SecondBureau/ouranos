class RecipientsController < ApplicationController
  
  def opening_track
    recipient = Recipient.find_by_token(params[:token])
    #logger.debug recipient.inspect
    unless recipient.nil?
      recipient.read_count = (recipient.read_count || 0) + 1
      recipient.last_read_at = Time.now
      recipient.save
    end
  logger.debug "Hello"
  logger.debug  File.atime(Rails.root.join( 'app', 'assets', 'images', 'logo_secondbureau.png'))
  send_file Rails.root.join( 'app', 'assets', 'images', 'logo_seconbureau.png'), :type => 'image/png', :disposition => 'inline'
end

end

