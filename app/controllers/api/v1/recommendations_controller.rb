class Api::V1::RecommendationsController < ApplicationController

  def search

    @user = User.find_by(username: params[:u])
    @user.refresh_access_token

    header = {
      Authorization: "Bearer #{@user.access_token}"
    }

    artist_search = RestClient.get("https://api.spotify.com/v1/search?q=#{params[:q]}&type=artist", header)
    artist_response = JSON.parse(artist_search.body)

    searched_artist_id = artist_response["artists"]["items"][0]["id"]

    recommendation_search = RestClient.get("https://api.spotify.com/v1/artists/#{searched_artist_id}/related-artists", header)
    recommendation_results = JSON.parse(recommendation_search.body)

    searched_artist_top_tracks = RestClient.get("https://api.spotify.com/v1/artists/#{searched_artist_id}/top-tracks?country=US", header)
    searched_artist_top_tracks_resp = JSON.parse(searched_artist_top_tracks.body)

    artist2_top_tracks = RestClient.get("https://api.spotify.com/v1/artists/#{recommendation_results["artists"][0]["id"]}/top-tracks?country=US", header)
    artist2_top_tracks_resp = JSON.parse(artist2_top_tracks.body)

    artist3_top_tracks = RestClient.get("https://api.spotify.com/v1/artists/#{recommendation_results["artists"][1]["id"]}/top-tracks?country=US", header)
    artist3_top_tracks_resp = JSON.parse(artist3_top_tracks.body)

    artist4_top_tracks = RestClient.get("https://api.spotify.com/v1/artists/#{recommendation_results["artists"][2]["id"]}/top-tracks?country=US", header)
    artist4_top_tracks_resp = JSON.parse(artist4_top_tracks.body)

    artists_object = {
      searched_artist: artist_response,
      recommended_artists: recommendation_results,
      searched_artist_tracks: searched_artist_top_tracks_resp,
      rec1_artist_tracks: artist2_top_tracks_resp,
      rec2_artist_tracks: artist3_top_tracks_resp,
      rec3_artist_tracks: artist4_top_tracks_resp
    }

    render json: artists_object

  end

  def search_on_click

    @user = User.find_by(username: params[:u])
    @user.refresh_access_token

    header = {
      Authorization: "Bearer #{@user.access_token}"
    }

    recommendation_search = RestClient.get("https://api.spotify.com/v1/artists/#{params[:q]}/related-artists?limit=3", header)
    recommendation_results = JSON.parse(recommendation_search.body)

    artist1_top_tracks = RestClient.get("https://api.spotify.com/v1/artists/#{recommendation_results["artists"][0]["id"]}/top-tracks?country=US", header)
    artist1_top_tracks_resp = JSON.parse(artist1_top_tracks.body)

    artist2_top_tracks = RestClient.get("https://api.spotify.com/v1/artists/#{recommendation_results["artists"][1]["id"]}/top-tracks?country=US", header)
    artist2_top_tracks_resp = JSON.parse(artist2_top_tracks.body)

    artist3_top_tracks = RestClient.get("https://api.spotify.com/v1/artists/#{recommendation_results["artists"][2]["id"]}/top-tracks?country=US", header)
    artist3_top_tracks_resp = JSON.parse(artist3_top_tracks.body)

    artists_object = {
      recommended_artists: recommendation_results,
      rec1_artist_tracks: artist1_top_tracks_resp,
      rec2_artist_tracks: artist2_top_tracks_resp,
      rec3_artist_tracks: artist3_top_tracks_resp
    }

    render json: artists_object

  end

end
