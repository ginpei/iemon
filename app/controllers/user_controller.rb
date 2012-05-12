class UserController < ApplicationController
  before_filter {
    login_required
  }

  def index
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to '/profile', notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end
end
