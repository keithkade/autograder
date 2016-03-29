require 'spec_helper'

describe LoginController do

  before :each do
    @bad_movie = double('Movie')
    @bad_movie.stub(:director).and_return(' ')
    @bad_movie.stub(:id).and_return('1')
    @bad_movie.stub(:title).and_return('bad title')

    @good_movie = double('Movie')
    @good_movie.stub(:director).and_return('good director')
    @good_movie.stub(:id).and_return('2')
    @good_movie.stub(:title).and_return('good title')

    Movie.stub(:find).with(@bad_movie.id).and_return(@bad_movie)
    Movie.stub(:find).with(@good_movie.id).and_return(@good_movie)
  end

  describe 'Allow students and admin to login' do
    it 'store user login in session' do
      Movie.should_receive(:same_director).with(@good_movie.director)
      get :same_director, {:id => @good_movie.id}
    end
  end

end
