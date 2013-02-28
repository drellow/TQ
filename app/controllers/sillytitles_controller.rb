class SillytitlesController < ApplicationController

  def new
    title = UsersHelper.new_title
    render :json => {:title => title}
  end
end
