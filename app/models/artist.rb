class Artist < ApplicationRecord

  has_many :users, through: :saved_artists
  has_many :saved_artists

end
