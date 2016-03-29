require 'rails_helper'

describe LoginController do

  before :each do
    @admin = double('User')

    @student = double('User')
    @student.stub(:id).and_return('1')
    @student.stub(:username).and_return('student')
    @student.stub(:password).and_return('root')

    @admin = double('User')
    @admin.stub(:id).and_return('1')
    @admin.stub(:username).and_return('admin')
    @admin.stub(:password).and_return('root')

    @helper = Object.new.extend LoginHelper
    @helper.stub(:log_in_student)
    @helper.stub(:log_out_student)

    @User = double('User')
    @User.stub(:is_valid)
    @User.stub(:is_valid)
  end

  describe 'Allow students and admin to login' do
    #TODO these don't pass. can't figure out how to access helper and documentation is slim
    #covered by cucumber though
    it 'should check if submitted credentials are a valid student' do
      @User.should_receive(:is_valid).with(@student.username, @student.password)
      post :create, { :user => @student.username, :password => @student.password }
    end
    it 'should login valid students' do
      @helper.should_receive(:log_in_student)
      post :create, { :user => @student.username, :password => @student.password }
    end
    it 'should logout students' do
      @helper.should_receive(:log_out_student)
      delete :destroy
    end
    it 'should redirect on logout' do
      response.should redirect_to(login_path)
      delete :destroy
    end
  end

end
