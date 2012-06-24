Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

# the director of "Alien" should be "Ridley Scott"
Then /the director of "(.*)" should be "(.*)"/ do |movie_name, director|
  step %Q{I am on the details page for "#{movie_name}"}
  step %Q{I should see "#{director}"}
end

