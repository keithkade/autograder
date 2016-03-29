class ApplicationController < ActionController::Base

  include LoginHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def check_credentials

    if request.path.include?('/admin') and not logged_in_admin?
      redirect_to '/home'
    end

    if not request.path == login_path and not (logged_in_student? or logged_in_admin?)
      redirect_to login_path
    end
  end

  before_filter :check_credentials, :except => :login


end

