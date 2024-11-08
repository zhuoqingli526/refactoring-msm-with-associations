require "rails_helper"

describe "/directors" do
  it "has a form", :points => 1 do
    visit "/directors"

    expect(page).to have_css("form", minimum: 1)
  end
end

describe "/directors" do
  it "has a label for 'Name' with text: 'Name'", :points => 1, hint: h("copy_must_match label_for_input") do
    visit "/directors"

    expect(page).to have_css("label", text: "Name")
  end
end

describe "/directors" do
  it "has at least one input elements", :points => 1, hint: h("label_for_input") do
    visit "/directors"

    expect(page).to have_css("input", minimum: 1)
  end
end

describe "/directors" do
  it "has a button with text 'Create director'", :points => 1, hint: h("copy_must_match") do
    visit "/directors"

    expect(page).to have_css("button", text: "Create director")
  end
end

describe "/directors" do
  it "creates a Director when 'Create director' form is submitted", :points => 5, hint: h("button_type") do
    initial_number_of_directors = Director.count
    test_name = "Joe Schmoe"

    visit "/directors"

    fill_in "Name", with: test_name
    click_on "Create director"
    final_number_of_directors = Director.count
    expect(final_number_of_directors).to eq(initial_number_of_directors + 1)
  end
end

describe "/directors" do
  it "saves the name when 'Create director' form is submitted", :points => 2, hint: h("label_for_input") do
    initial_number_of_directors = Director.count
    test_name = "Joe Schmoe"

    visit "/directors"

    fill_in "Name", with: test_name
    click_on "Create director"

    last_director = Director.order(created_at: :asc).last
    expect(last_director.name).to eq(test_name)
  end
end


describe "/directors/[ID]" do
  it "displays the name of the director", :points => 1 do

    director = Director.new
    director.name = "Joe Schmoe"
    director.save

    visit "/directors/#{director.id}"

    expect(page).to have_content(director.name)
  end
end

describe "/delete_director/[PHOTO ID]" do
  it "removes a record from the Director table", :points => 1 do

    director = Director.new
    director.name = "Joe Schmoe"
    director.save

    visit "/delete_director/#{director.id}"

    expect(Director.exists?(director.id)).to be(false)
  end
end

describe "/delete_director/[PHOTO ID]" do
  it "redirects to /directors", :points => 1, hint: h("redirect_vs_render") do

    director = Director.new
    director.name = "Joe Schmoe"
    director.save

    visit "/delete_director/#{director.id}"

    expect(page).to have_current_path("/directors")
  end
end

describe "/directors/[ID]" do
  it "has at least one form", :points => 1 do

    director = Director.new
    director.name = "Joe Schmoe"
    director.save

    visit "/directors/#{director.id}"

    expect(page).to have_css("form", minimum: 1)
  end
end

describe "/directors/[ID]" do
  it "has a label with text 'Image'", :points => 1, hint: h("copy_must_match label_for_input") do
 
    director = Director.new
    director.name = "Joe Schmoe"
    director.image = "https://some.test/image-#{Time.now.to_i}.jpg"
    director.save

    visit "/directors/#{director.id}"

    expect(page).to have_css("label", text: "Image")
  end
end

describe "/directors/[ID]" do
  it "has a button with text 'Update director'", :points => 1, hint: h("copy_must_match label_for_input") do

    director = Director.new
    director.name = "Joe Schmoe"
    director.image = "https://some.test/image-#{Time.now.to_i}.jpg"
    director.save

    visit "/directors/#{director.id}"

    expect(page).to have_css("button", text: "Update director")
  end
end

describe "/directors/[ID]" do
  it "'Update director' form has Image prepopulated in an input element", :points => 1, hint: h("value_attribute") do

    director = Director.new
    director.name = "Joe Schmoe"
    director.image = "https://some.test/image-#{Time.now.to_i}.jpg"
    director.save

    visit "/directors/#{director.id}"

    expect(page).to have_css("input[value='#{director.image}']")
  end
end

describe "/directors/[ID]" do
  it "'Update director' form updates Image when submitted", :points => 1, hint: h("label_for_input button_type") do

    director = Director.new
    director.name = "Joe Schmoe"
    director.image = "https://some.test/image-#{Time.now.to_i}.jpg"
    director.save

    new_image = "https://some.test/image-1.jpg"

    visit "/directors/#{director.id}"
    fill_in "Image", with: new_image
    click_on "Update director"

    director_as_revised = Director.find(director.id)

    expect(director_as_revised.image).to eq(new_image)
  end
end

describe "/directors/[ID]" do
  it "'Update director' form redirects to the director's details page when updating director", :points => 1, hint: h("embed_vs_interpolate redirect_vs_render") do

    director = Director.new
    director.name = "Joe Schmoe"
    director.image = "https://some.test/image-#{Time.now.to_i}.jpg"
    director.save

    new_image = "https://some.test/image-1.jpg"

    visit "/directors/#{director.id}"
    fill_in "Image", with: new_image
    click_on "Update director"

    expect(page).to have_current_path("/directors/#{director.id}")
  end
end
