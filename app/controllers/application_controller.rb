class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :logged_in?

  private

  def logged_in?
    !!session[:user_id]
  end
end
