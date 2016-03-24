class LoginController < ApplicationController
  def index
  end

  def create
    #do validation of credentials

    if params['user'] == 'student' && params['password'] == 'root'
      redirect_to '/home'
    elsif params['user'] == 'admin' && params['password'] == 'root'
      redirect_to '/admin/classes'
    else
      redirect_to '/login'
    end

  end
end
