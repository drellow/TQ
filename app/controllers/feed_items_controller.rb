class FeedItemsController < ApplicationController
  
  def update
    feeditem = FeedItem.find(params[:id])
    FeedItem.where(:scope => feeditem.scope).update_all(:read => true)
    feeditem.save
    redirect_to feeditem.path
  end
end
