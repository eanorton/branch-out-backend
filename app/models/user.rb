class User < ApplicationRecord

  has_many :saved_artists
  has_many :artists, through: :saved_artists

  validates :username, uniqueness: true, presence: true

  def expired_token?
    (Time.now - self.updated_at) > 3300
  end

  def refresh_access_token

    if self.expired_token?
      body = {
        grant_type: "refresh_token",
        refresh_token: self.refresh_token,
        client_id: ENV["CLIENT_ID"],
        client_secret: ENV["CLIENT_SECRET"]
      }
      auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
      auth_params = JSON.parse(auth_response)
      self.update(access_token: auth_params["access_token"])
    else
      puts "Access token still valid"
    end
  end

end
