class Api::V1::PlaylistsController < ApplicationController

  def create

    @user = User.first

    @user.refresh_access_token

    header = {
      Authorization: "Bearer #{@user.access_token}"
    }

    body = {
      name: "New Playlist",
      description: "New playlist description",
      public: false
    }

  end

  def edit

  end

end
