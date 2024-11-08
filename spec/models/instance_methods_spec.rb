require "rails_helper"

describe "Movie" do
  it "has an instance method defined called 'director'", points: 2 do

    expect(Movie.method_defined?(:director)).to eq(true),
      "Expected Movie class to define an instance method called, 'director', but didn't find one."
  end
end

describe "Director" do
  it "has an instance method defined called 'filmography'", points: 2 do

    expect(Director.method_defined?(:filmography)).to eq(true),
      "Expected Director class to define an instance method called, 'filmography', but didn't find one."
  end
end

describe "Actor" do
  it "has an instance method defined called 'characters'", points: 2 do

    expect(Actor.method_defined?(:characters)).to eq(true),
      "Expected Actor class to define an instance method called, 'characters', but didn't find one."
  end
end

# describe "Actor" do
#   it "has an instance method defined called 'filmography'", points: 2 do

#     expect(Actor.method_defined?(:filmography)).to eq(true),
#       "Expected Actor class to define an instance method called, 'filmography', but didn't find one."
#   end
# end

describe "Character" do
  it "has an instance method defined called 'movie'", points: 2 do

    expect(Character.method_defined?(:movie)).to eq(true),
      "Expected Character class to define an instance method called, 'movie', but didn't find one."
  end
end
