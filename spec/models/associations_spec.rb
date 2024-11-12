require "rails_helper"

RSpec.describe Movie, type: :model do
  describe "belongs to a Director", points: 2 do
    it { should belong_to(:director).class_name("Director") }
  end
end

RSpec.describe Movie, type: :model do
  describe "has many cast", points: 2 do
    it { should have_many(:cast).through(:characters).source(:actor) }
  end
end

RSpec.describe Director, type: :model do
  describe "has many filmography", points: 2 do
    it { should have_many(:filmography).class_name("Movie") }
  end
end

RSpec.describe Actor, type: :model do
  describe "has many characters", points: 2 do
    it { should have_many(:characters).class_name("Character") }
  end
end

RSpec.describe Actor, type: :model do
  describe "has many filmography", points: 2 do
    it { should have_many(:filmography).through(:characters).source(:movie) }
  end
end

RSpec.describe Character, type: :model do
  describe "belongs to a Movie", points: 2 do
    it { should belong_to(:movie).class_name("Movie") }
  end
end
