class User < ApplicationRecord

  has_many :saved_artists
  has_many :artists, through: :saved_artists

  validates :username, uniqueness: true, presence: true

  def expired_token?
    (Time.now - self.updated_at) > 3300
  end

end
