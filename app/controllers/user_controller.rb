class UserController < ApplicationController
  before_filter {
    login_required
  }

  def index
  end

  def edit
  end
end
