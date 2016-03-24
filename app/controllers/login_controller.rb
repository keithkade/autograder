class LoginController < ApplicationController
  def index
    @message = flash[:message]
  end

  def create
    #todo validation of credentials
    if params['user'] == 'student' && params['password'] == 'root'
      redirect_to '/home'
    elsif params['user'] == 'admin' && params['password'] == 'root'
      redirect_to '/admin/classes'
    else
      flash[:message] = "Login Failed. Please Try Again"
      redirect_to '/login'
    end

  end
end
