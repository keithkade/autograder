require 'rails_helper'

describe LoginController do

  let(:helpers) { LoginController.helpers }

  before :each do
    @student = double('Student')
    @student.stub(:id).and_return('1')
    @student.stub(:username).and_return('dman')
    @student.stub(:password).and_return('password')
  end

  describe 'Allow students and admin to login' do
    #covered by cucumber though
    it 'should check if submitted credentials are a valid student' do
      Student.should_receive(:find_by).with({UserName: @student.username, Password: @student.password})
      post :create, { :user => @student.username, :password => @student.password }
    end
    #TODO these don't pass. can't figure out how to access helper and documentation is slim
    it 'should login valid students' do
      controller.should_receive(:log_in_student)
      post :create, { :user => @student.username, :password => @student.password }
    end
    it 'should logout students' do
      controller.should_receive(:log_out_student)
      post :create, { :user => @student.username, :password => @student.password }
      delete :destroy
    end
  end

end
