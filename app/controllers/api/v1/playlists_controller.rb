class Api::V1::PlaylistsController < ApplicationController

  def create
    @user = User.find_by(username: params[:u])
    @user.refresh_access_token

    body = {
      name: "Branch Out Playlist",
      description: "Playlist made on Branch Out",
      collaborative: false,
      public: true
    }

    create_playlist = RestClient::Request.execute(
      method: :post,
      url: "https://api.spotify.com/v1/users/#{@user.username}/playlists",
      payload: body.to_json,
      headers: {
        Authorization: "Bearer #{@user.access_token}",
        content_type: "application/json"
      }
    )

    playlist_response = JSON.parse(create_playlist.body)

    render json: playlist_response
  end

  def add_track
    @user = User.find_by(username: params[:u])
    @user.refresh_access_token

    track_body = {
      "uris": params[:t]
    }

    playlist_id = params[:p][37..100]

    add_tracks = RestClient::Request.execute(
      method: :post,
      url: "https://api.spotify.com/v1/users/#{@user.username}/playlists/#{playlist_id}/tracks?uris=#{params[:t]}",
      headers: {
        Authorization: "Bearer #{@user.access_token}",
        content_type: "application/json"
      }
    )

    tracks_response = JSON.parse(add_tracks.body)

    render json: tracks_response
  end

end
