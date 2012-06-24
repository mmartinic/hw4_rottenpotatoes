require 'spec_helper'

describe MoviesController do
  describe 'find movies by same director' do
    it 'should call the model method that performs find by same director' do
      fake_results = [mock('Movie'), mock('Movie')]
      Movie.should_receive(:find_by_same_director).with('4').and_return(fake_results)
      get :same_director, {:id => '4'}
    end
    it 'should select the same_director template for rendering' do
      fake_results = [mock('Movie'), mock('Movie')]
      Movie.stub(:find_by_same_director).and_return(fake_results)
      get :same_director, {:id => '4'}
      response.should render_template('same_director')
    end
    it 'should make the list of movies with same director available to that template' do
      fake_results = [mock('Movie'), mock('Movie')]
      Movie.stub(:find_by_same_director).and_return(fake_results)
      get :same_director, {:id => '4'}
      assigns(:movies).should == fake_results
    end
    it 'should select index template if no director is available for given movie' do
      Movie.stub(:find_by_same_director).and_return(nil)
      Movie.stub(:find).and_return(mock('Movie', :title => 'Alien'))
      get :same_director, {:id => '4'}
      response.should_not render_template('same_director')
    end
  end
  describe 'create new movie' do
    it 'should call the model method create' do
      params = {'id' => '4', 'title' => 'To kill a mockingbird'}
      Movie.should_receive(:create!).with(params).and_return(mock('Movie', params))
      put :create, {:movie => params}
    end
  end
  describe 'delete movie' do
    it 'should call the model methods find and destroy' do
      params = {:id => 4}
      m = mock('Movie', :title => 'To kill a mockingbird')
      m.should_receive(:destroy)
      Movie.should_receive(:find).with('4').and_return(m)
      delete :destroy, params
    end
  end
end