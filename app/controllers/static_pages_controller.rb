class StaticPagesController < ApplicationController

  def home
    @user = current_user  #I need to create this in the sessions controller 
  end

end
