# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  description :text
#  duration    :integer
#  image       :string
#  title       :string
#  year        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  director_id :integer
#
class Movie < ApplicationRecord
  validates(:director_id, presence: true)
  validates(:title, uniqueness: true)

  #belongs_to(:director, foreign_key: "director_id", class_name: "Director")

  belongs_to :director

  #has_many(:characters, foreign_key: "movie_id", class_name:"Character")

  has_many :characters

  has_many(:cast, through: :characters, source: :actor)

end
