class UsersController < ApplicationController

  def index
    @user = #User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    #@user_image = @user.profile_image
  end

  def edit
  end
  
  def update
  end

end
