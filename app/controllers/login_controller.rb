class LoginController < ApplicationController
  include LoginHelper

  def new
  end

  def create
    #todo validation of credentials
    #user.is_valid_student
    if params['user'] == 'student' && params['password'] == 'root'
      redirect_to '/home'
    #user.is_valid_admin
    elsif params['user'] == 'admin' && params['password'] == 'root'
      redirect_to '/admin/classes'
    else
      flash.now[:danger] = 'Login Failed: Invalid email/password combination'
      render 'new'
    end

  def destroy
    log_out
    redirect_to '/'
  end

  end
end
