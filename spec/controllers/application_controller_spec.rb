require 'rails_helper'

describe ApplicationController, :type => :controller do

  controller do
    before_filter :check_credentials, :except => :login
    def index
    end
    def admin
    end
    def home
    end
    def login
    end
  end

  before do
    @routes.draw do
      get '/anonymous/index'
      get '/anonymous/admin'
      get '/anonymous/login'
      get '/anonymous/home'
    end
  end

  describe 'Redirect if credentials are bad' do
    it 'should redirect to login page if not logged in at all' do
      helper = double('LoginHelper')
      helper.stub(:logged_in_student?).and_return(false)
      helper.stub(:logged_in_admin?).and_return(false)
      get :index
      response.should redirect_to :login
    end


    it 'should redirect student if they try to access an admin page' do
      helper = double('LoginHelper')
      helper.stub(:logged_in_student?).and_return(true)
      helper.stub(:logged_in_admin?).and_return(false)
      get :admin
      response.should redirect_to :home
    end
  end

end
