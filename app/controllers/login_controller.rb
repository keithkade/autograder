class LoginController < ApplicationController
  include LoginHelper

  def new
    if logged_in_admin?
      redirect_to '/admin/courses'
    elsif logged_in_student?
      redirect_to '/home'
    end
  end

  def create
    user = Student.find_by(UserName: params['user'])

    if not user.nil? and user.authenticate(params['password'])
      log_in_student(user.id)
      flash[:notice] = "Welcome #{user.Name}!"
      redirect_to '/home'
    elsif params['user'] == Rails.application.secrets.admin_username && params['password'] == Rails.application.secrets.admin_password
      log_in_admin
      flash[:notice] = 'Welcome Admin!'
      redirect_to '/admin/courses'
    else
      flash.now[:danger] = 'Login Failed: Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    if logged_in_student?
      log_out_student
    end
    if logged_in_admin?
      log_out_admin
    end

    redirect_to '/'
  end

end
