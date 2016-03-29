class LoginController < ApplicationController
  include LoginHelper

  def new
  end

  def create
    #todo check user model to see if valid
    #user.is_valid_student
    if params['user'] == 'student' && params['password'] == 'root'
      log_in_student(params['user'])
      redirect_to '/home'
    elsif params['user'] == Rails.application.secrets.admin_username && params['password'] == Rails.application.secrets.admin_password
      log_in_admin
      redirect_to '/admin/courses'
    else
      flash.now[:danger] = 'Login Failed: Invalid email/password combination'
      render 'new'
    end

  def destroy
    log_out_student
    redirect_to '/'
  end

  end
end
