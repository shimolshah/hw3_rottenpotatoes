# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  # debugger
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  # flunk "Unimplemented"
  assert(body.index(e1) < body.index(e2))
  # debugger
  # p body
end

Then /the following checkboxes should be (un)?checked: (.*)/ do |uncheck, rating_list|
  rating_list.split(", ").each do |item|
    if uncheck!=nil 
      #uncheck("ratings_"+item)
      find("#ratings_" + item).should_not be_checked
      # assert !field_labeled("#ratings_" + item).checked?
    else
      find("#ratings_" + item).should be_checked
      # assert field_labeled("#ratings_" + item).checked?
    end
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(", ").each do |item|
    if uncheck!=nil 
      uncheck("ratings_"+item)
    else
      check("ratings_"+item)
    end
  end
end

Then /I should see all of the movies/ do 
  # debugger
  assert (Movie.count == find("#movies").all('tr').count - 1)
  
end