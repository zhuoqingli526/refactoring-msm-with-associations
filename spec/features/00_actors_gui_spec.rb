require "rails_helper"

describe "/actors" do
  it "has a form", :points => 1 do
    visit "/actors"

    expect(page).to have_css("form", minimum: 1)
  end
end

describe "/actors" do
  it "has a label for 'Name' with text: 'Name'", :points => 1, hint: h("copy_must_match label_for_input") do
    visit "/actors"

    expect(page).to have_css("label", text: "Name")
  end
end

describe "/actors" do
  it "has at least one input elements", :points => 1, hint: h("label_for_input") do
    visit "/actors"

    expect(page).to have_css("input", minimum: 1)
  end
end

describe "/actors" do
  it "has a button with text 'Create actor'", :points => 1, hint: h("copy_must_match") do
    visit "/actors"

    expect(page).to have_css("button", text: "Create actor")
  end
end

describe "/actors" do
  it "creates an Actor when 'Create actor' form is submitted", :points => 5, hint: h("button_type") do
    initial_number_of_actors = Actor.count
    test_name = "Joe Schmoe"

    visit "/actors"

    fill_in "Name", with: test_name
    click_on "Create actor"
    final_number_of_actors = Actor.count
    expect(final_number_of_actors).to eq(initial_number_of_actors + 1)
  end
end

describe "/actors" do
  it "saves the name when 'Create actor' form is submitted", :points => 2, hint: h("label_for_input") do
    initial_number_of_actors = Actor.count
    test_name = "Joe Schmoe"

    visit "/actors"

    fill_in "Name", with: test_name
    click_on "Create actor"

    last_actor = Actor.order(created_at: :asc).last
    expect(last_actor.name).to eq(test_name)
  end
end


describe "/actors/[ID]" do
  it "displays the name of the actor", :points => 1 do

    actor = Actor.new
    actor.name = "Joe Schmoe"
    actor.save

    visit "/actors/#{actor.id}"

    expect(page).to have_content(actor.name)
  end
end

describe "/delete_actor/[PHOTO ID]" do
  it "removes a record from the Actor table", :points => 1 do

    actor = Actor.new
    actor.name = "Joe Schmoe"
    actor.save

    visit "/delete_actor/#{actor.id}"

    expect(Actor.exists?(actor.id)).to be(false)
  end
end

describe "/delete_actor/[PHOTO ID]" do
  it "redirects to /actors", :points => 1, hint: h("redirect_vs_render") do

    actor = Actor.new
    actor.name = "Joe Schmoe"
    actor.save

    visit "/delete_actor/#{actor.id}"

    expect(page).to have_current_path("/actors")
  end
end

describe "/actors/[ID]" do
  it "has at least one form", :points => 1 do

    actor = Actor.new
    actor.name = "Joe Schmoe"
    actor.save

    visit "/actors/#{actor.id}"

    expect(page).to have_css("form", minimum: 1)
  end
end

describe "/actors/[ID]" do
  it "has a label with text 'Image'", :points => 1, hint: h("copy_must_match label_for_input") do
 
    actor = Actor.new
    actor.name = "Joe Schmoe"
    actor.image = "https://some.test/image-#{Time.now.to_i}.jpg"
    actor.save

    visit "/actors/#{actor.id}"

    expect(page).to have_css("label", text: "Image")
  end
end

describe "/actors/[ID]" do
  it "has a button with text 'Update actor'", :points => 1, hint: h("copy_must_match label_for_input") do

    actor = Actor.new
    actor.name = "Joe Schmoe"
    actor.image = "https://some.test/image-#{Time.now.to_i}.jpg"
    actor.save

    visit "/actors/#{actor.id}"

    expect(page).to have_css("button", text: "Update actor")
  end
end

describe "/actors/[ID]" do
  it "'Update actor' form has Image prepopulated in an input element", :points => 1, hint: h("value_attribute") do

    actor = Actor.new
    actor.name = "Joe Schmoe"
    actor.image = "https://some.test/image-#{Time.now.to_i}.jpg"
    actor.save

    visit "/actors/#{actor.id}"

    expect(page).to have_css("input[value='#{actor.image}']")
  end
end

describe "/actors/[ID]" do
  it "'Update actor' form updates Image when submitted", :points => 1, hint: h("label_for_input button_type") do

    actor = Actor.new
    actor.name = "Joe Schmoe"
    actor.image = "https://some.test/image-#{Time.now.to_i}.jpg"
    actor.save

    new_image = "https://some.test/image-1.jpg"

    visit "/actors/#{actor.id}"
    fill_in "Image", with: new_image
    click_on "Update actor"

    actor_as_revised = Actor.find(actor.id)

    expect(actor_as_revised.image).to eq(new_image)
  end
end

describe "/actors/[ID]" do
  it "'Update actor' form redirects to the actor's details page when updating actor", :points => 1, hint: h("embed_vs_interpolate redirect_vs_render") do

    actor = Actor.new
    actor.name = "Joe Schmoe"
    actor.image = "https://some.test/image-#{Time.now.to_i}.jpg"
    actor.save

    new_image = "https://some.test/image-1.jpg"

    visit "/actors/#{actor.id}"
    fill_in "Image", with: new_image
    click_on "Update actor"

    expect(page).to have_current_path("/actors/#{actor.id}")
  end
end
