# -*- encoding: utf-8 -*-

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
    # '非公開'を''に置き換える
    %w(gender age job).each do |e|
      params[:user][e] = '' if '非公開' == params[:user][e]
    end
    if @user.update_attributes(params[:user])
      redirect_to '/profile', notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end
end
