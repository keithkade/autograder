require 'test_helper'

=begin
class LoginHelperTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
end
=end

describe Movie do
  describe 'same director' do
    #it 'should return movies with the same director' do
    #  movie = Movie.create(:title=> 'test', :rating=> 'G', :director=> 'good director')
    #  movie2 = Movie.create(:title=> 'test', :rating=> 'G', :director=> 'good director')
    #  movie3 = Movie.create(:title=> 'test', :rating=> 'G', :director=> 'bad director')
    #  Movie.same_director('good director').should eq([movie, movie2])
    #end
    it "should get index" do
      get :index
      assert_response :success
    end
  end
end
