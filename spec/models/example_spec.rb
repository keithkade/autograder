require 'spec_helper'

=begin
describe Movie do
  describe 'same director' do
    it 'should return movies with the same director' do
      movie = Movie.create(:title=> 'test', :rating=> 'G', :director=> 'good director')
      movie2 = Movie.create(:title=> 'test', :rating=> 'G', :director=> 'good director')
      movie3 = Movie.create(:title=> 'test', :rating=> 'G', :director=> 'bad director')
      Movie.same_director('good director').should eq([movie, movie2])
    end
  end
end
=end