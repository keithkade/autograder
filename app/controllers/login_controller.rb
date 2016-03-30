class LoginController < ApplicationController
  include LoginHelper

  def new
  end

  def create
    user = Student.find_by(UserName: params['user'], Password:  params['password'])
    if not user.nil?
      log_in_student(user.id)
      redirect_to '/home'
    elsif params['user'] == Rails.application.secrets.admin_username && params['password'] == Rails.application.secrets.admin_password
      log_in_admin
      flash[:notice] = 'Welcome Admin!'
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
