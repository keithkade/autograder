require 'rails_helper'

describe LoginHelper, :type => :helper do

  describe 'Keep students logged in' do
    it 'store succesful student login in session' do
      log_in_student('1')
      expect(session[:user_id]).to eq('1')
    end
    it 'remove student id from session on log out' do
      log_out_student
      expect(session.key?(:user_id)).to be_falsey
    end
    it 'should check that a student is logged in based on session' do
      session[:user_id] = '1'
      expect(logged_in_student?).to be_truthy
    end
  end

  describe 'Keep admin logged in' do
    it 'store succesful admin login in session' do
      log_in_admin
      expect(session[:is_admin]).to be_truthy
    end
    it 'remove admin id from session on log out' do
      log_out_admin
      expect(session.key?(:is_admin)).to be_falsey
    end
    it 'should check that a admin is logged in based on session' do
      session[:is_admin] = true
      expect(logged_in_admin?).to be_truthy
    end
  end

end
