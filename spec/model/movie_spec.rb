require 'spec_helper'

describe Movie do
  describe 'search for same director' do
    context 'for movie that has director' do
      it 'should call find for given id' do
        Movie.should_receive(:find).with(4).and_return(mock('Movie', :director => nil))
        Movie.find_by_same_director(4).should be_nil
      end
      it 'should call find_all_by_director for director of the given movie' do
        Movie.should_receive(:find).with(4).and_return(mock('Movie', :director => 'Ridley Scott'))
        fake_results = [mock('Movie'), mock('Movie')]
        Movie.should_receive(:find_all_by_director).with('Ridley Scott').and_return(fake_results)
        Movie.find_by_same_director(4).should == fake_results
      end
    end
  end
end