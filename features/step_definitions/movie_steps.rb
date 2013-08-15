# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    newMovie = Movie.new(movie)
    newMovie.save
  end
#flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
# flunk "Unimplemented"
  raise e1
  raise e2
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rbi
  checking = uncheck == nil ? "check" : "uncheck"
  rating_list.split(",").each do |rate|
    "When I #{checking} #{rate}"
  end
end

When /I press (.*)/ do |action|
   "When I press #{action}"
end

Then /I should see: (.*)/ do |movie_list|
    movie_list.split(",").each do |movie|
        "Then I should see #{movie}"
    end
end

Then /I should not see: (.*)/ do |movie_list|
    movie_list.split(",").each do |movie|
        "Then I should not see #{movie}"
    end
end

Then /I should see all of the movies/ do
  rows = page.all('table#movies tbody tr')
  assert rows.count == Movie.all.count
end

Then /I should see (.*) before (.*)/ do |before, after|
  rows = page.all('table#movies tbody tr')
  before_index = -1
  after_index = -1
  rows.each_with_index do |row, index|
    before_index = index if row.all('td')[0].text == before
    after_index = index if row.all('td')[0].text == after
  end
  assert before_index > 0
  assert after_index > 0
  assert before_index < after_index
end
