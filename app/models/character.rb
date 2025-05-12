# == Schema Information
#
# Table name: characters
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  actor_id   :integer
#  movie_id   :integer
#
class Character < ApplicationRecord
  #belongs_to(:movie, foreign_key: "movie_id", class_name: "Movie" )
  #belongs_to(:movie, class_name: "Movie" )

  belongs_to(:movie)

  #belongs_to(:actor, foreign_key:"actor_id", class_name: "Actor")

  belongs_to :actor
end
