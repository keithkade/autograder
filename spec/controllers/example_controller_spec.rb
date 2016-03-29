
=begin
require 'spec_helper'

describe MoviesController do

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

  describe 'Find movies with same director' do
    it 'should call the model method that finds movies with same director with right arguments' do
      Movie.should_receive(:same_director).with(@good_movie.director)
      get :same_director, {:id => @good_movie.id}
    end
    it 'should render the same director template on success' do
      #stubbing a good response
      Movie.stub(:same_director).and_return([@good_movie])
      get :same_director, {:id => @good_movie.id}
      response.should render_template('same_director')
    end
    it 'should make same director results available to that template' do
      results = [double('Movie'), double('Movie')]
      Movie.stub(:same_director).and_return(results)
      get :same_director, {:id => @good_movie.id}
      assigns(:movies).should == results
    end
    it 'should render movies homepage on failure' do
      #stubbing a bad response
      Movie.stub(:same_director).and_return([])
      get :same_director, {:id => @bad_movie.id}
      response.should redirect_to(movies_path)
    end
  end

  describe 'Sort and filter movies' do
    it 'should save sort params in session' do
      get :index, {:sort => 'test'}
      session[:sort].should eq('test')
    end
    it 'save ratings params to session' do
      get :index, {:ratings => 'test'}
      session[:ratings].should eq('test')
    end
  end
end
=end
