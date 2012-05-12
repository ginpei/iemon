class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :reset_session_expires

  rescue_from User::UnAuthorized, :with => -> { redirect_to '/auth/twitter' }
  rescue_from User::NotAdminister , :with => -> { render :text =>'NotAdminister' }

  private

  def reset_session_expires
    request.session_options[:expire_after] = 2.weeks
  end

  def current_user
    @current_user ||= User.where(id: session[:user_id]).first
  end

  helper_method :current_user

  def login_required
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      raise User::UnAuthorized
    end
  end

  def only_administer
    login_required
    administers = %w(dan5ya masata_masata ginpei_jp uetsuhara understandard)
    unless administers.include?(current_user.screen_name)
      raise User::NotAdminister
    end
  end
end
