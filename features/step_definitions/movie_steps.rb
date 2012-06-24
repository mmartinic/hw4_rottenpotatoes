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

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body  is the entire content of the page as a string.
  index1 = page.body.index(e1)
  index2 = page.body.index(e2)
  index1.should < index2
end

Then /I should see all of the movies/ do
  Movie.count.should == page.body.scan(/<tr>/).length - 1
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(",").map{|x| x.strip}.each do |rating|
    if uncheck
      step %Q{I uncheck "ratings_#{rating}"}
    else
      step %Q{I check "ratings_#{rating}"}
    end
  end
end


