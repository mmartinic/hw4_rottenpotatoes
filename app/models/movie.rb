class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.find_by_same_director(id)
    movie = Movie.find(id)
    director = movie.director
    if not (director.nil? or director == "") then
      Movie.find_all_by_director(director)
    end
  end
  
end
