describe LoginHelper do

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

  describe 'Keep users logged in' do
    it 'store succesful student login in session' do
      log_in('1')
      assert(session.key?('1'))
    end
    it 'remove user id from session on log out' do
      log_out
      #assert(not session.key?(:user_id))
    end
  end

end
