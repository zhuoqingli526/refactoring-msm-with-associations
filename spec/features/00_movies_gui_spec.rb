require "rails_helper"

describe "/movies" do
  it "has a form", :points => 1 do
    visit "/movies"

    expect(page).to have_css("form", minimum: 1)
  end
end

describe "/movies" do
  it "has a label for 'Title' with text: 'Title'", :points => 1, hint: h("copy_must_match label_for_input") do
    visit "/movies"

    expect(page).to have_css("label", text: "Title")
  end
end

describe "/movies" do
  it "has at least one input elements", :points => 1, hint: h("label_for_input") do
    visit "/movies"

    expect(page).to have_css("input", minimum: 1)
  end
end

describe "/movies" do
  it "has a button with text 'Create movie'", :points => 1, hint: h("copy_must_match") do
    visit "/movies"

    expect(page).to have_css("button", text: "Create movie")
  end
end

describe "/movies" do
  it "creates a Movie when 'Create movie' form is submitted", :points => 5, hint: h("button_type") do
    initial_number_of_movies = Movie.count
    test_title = "Flubber"

    visit "/movies"

    fill_in "Title", with: test_title
    click_on "Create movie"
    final_number_of_movies = Movie.count
    expect(final_number_of_movies).to eq(initial_number_of_movies + 1)
  end
end

describe "/movies" do
  it "saves the title when 'Create movie' form is submitted", :points => 2, hint: h("label_for_input") do
    initial_number_of_movies = Movie.count
    test_title = "Flubber"

    visit "/movies"

    fill_in "Title", with: test_title
    click_on "Create movie"

    last_movie = Movie.order(created_at: :asc).last
    expect(last_movie.title).to eq(test_title)
  end
end


describe "/movies/[ID]" do
  it "displays the title of the movie", :points => 1 do
    director = Director.new
    director.name = "Scout Young"
    director.dob = 27.years.ago
    director.image = ""
    director.save

    movie = Movie.new
    movie.title = "Flubber"
    movie.director_id = director.id
    movie.year = 1999
    movie.description = "Just a green lil' guy"
    movie.duration = 95
    movie.save

    visit "/movies/#{movie.id}"

    expect(page).to have_content(movie.title)
  end
end

describe "/delete_movie/[PHOTO ID]" do
  it "removes a record from the Movie table", :points => 1 do
    director = Director.new
    director.name = "Scout Young"
    director.dob = 27.years.ago
    director.image = ""
    director.save

    movie = Movie.new
    movie.title = "Flubber"
    movie.director_id = director.id
    movie.year = 1999
    movie.description = "Just a green lil' guy"
    movie.duration = 95
    movie.save

    visit "/delete_movie/#{movie.id}"

    expect(Movie.exists?(movie.id)).to be(false)
  end
end

describe "/delete_movie/[PHOTO ID]" do
  it "redirects to /movies", :points => 1, hint: h("redirect_vs_render") do
    director = Director.new
    director.name = "Scout Young"
    director.dob = 27.years.ago
    director.image = ""
    director.save

    movie = Movie.new
    movie.title = "Flubber"
    movie.director_id = director.id
    movie.year = 1999
    movie.description = "Just a green lil' guy"
    movie.duration = 95
    movie.year = 1999
    movie.save

    visit "/delete_movie/#{movie.id}"

    expect(page).to have_current_path("/movies")
  end
end

describe "/movies/[ID]" do
  it "has at least one form", :points => 1 do
    director = Director.new
    director.name = "Scout Young"
    director.dob = 27.years.ago
    director.image = ""
    director.save

    movie = Movie.new
    movie.title = "Flubber"
    movie.director_id = director.id
    movie.year = 1999
    movie.description = "Just a green lil' guy"
    movie.duration = 95
    movie.year = 1999
    movie.save

    visit "/movies/#{movie.id}"

    expect(page).to have_css("form", minimum: 1)
  end
end

describe "/movies/[ID]" do
  it "has a label with text 'Image'", :points => 1, hint: h("copy_must_match label_for_input") do
    director = Director.new
    director.name = "Scout Young"
    director.dob = 27.years.ago
    director.image = ""
    director.save

    movie = Movie.new
    movie.title = "Flubber"
    movie.image = "https://some.test/image-#{Time.now.to_i}.jpg"
    movie.description = "Green guy soft"
    movie.save

    visit "/movies/#{movie.id}"

    expect(page).to have_css("label", text: "Image")
  end
end

describe "/movies/[ID]" do
  it "has a button with text 'Update movie'", :points => 1, hint: h("copy_must_match label_for_input") do
    director = Director.new
    director.name = "Scout Young"
    director.dob = 27.years.ago
    director.image = ""
    director.save

    movie = Movie.new
    movie.title = "Flubber"
    movie.image = "https://some.test/image-#{Time.now.to_i}.jpg"
    movie.description = "Green guy soft"
    movie.save

    visit "/movies/#{movie.id}"

    expect(page).to have_css("button", text: "Update movie")
  end
end

describe "/movies/[ID]" do
  it "'Update movie' form has Image prepopulated in an input element", :points => 1, hint: h("value_attribute") do
    director = Director.new
    director.name = "Scout Young"
    director.dob = 27.years.ago
    director.image = ""
    director.save

    movie = Movie.new
    movie.title = "Flubber"
    movie.image = "https://some.test/image-#{Time.now.to_i}.jpg"
    movie.description = "Green guy soft"
    movie.save

    visit "/movies/#{movie.id}"

    expect(page).to have_css("input[value='#{movie.image}']")
  end
end

describe "/movies/[ID]" do
  it "'Update movie' form updates Image when submitted", :points => 1, hint: h("label_for_input button_type") do
    director = Director.new
    director.name = "Scout Young"
    director.dob = 27.years.ago
    director.image = ""
    director.save

    movie = Movie.new
    movie.title = "Flubber"
    movie.image = "https://some.test/image-#{Time.now.to_i}.jpg"
    movie.description = "Green guy soft"
    movie.save

    new_image = "https://some.test/image-1.jpg"

    visit "/movies/#{movie.id}"
    fill_in "Image", with: new_image
    click_on "Update movie"

    movie_as_revised = Movie.find(movie.id)

    expect(movie_as_revised.image).to eq(new_image)
  end
end

describe "/movies/[ID]" do
  it "'Update movie' form redirects to the movie's details page when updating movie", :points => 1, hint: h("embed_vs_interpolate redirect_vs_render") do
    director = Director.new
    director.name = "Scout Young"
    director.dob = 27.years.ago
    director.image = ""
    director.save

    movie = Movie.new
    movie.title = "Flubber"
    movie.image = "https://some.test/image-#{Time.now.to_i}.jpg"
    movie.description = "Green guy soft"
    movie.save

    new_image = "https://some.test/image-1.jpg"

    visit "/movies/#{movie.id}"
    fill_in "Image", with: new_image
    click_on "Update movie"

    expect(page).to have_current_path("/movies/#{movie.id}")
  end
end
