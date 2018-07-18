class Api::V1::RecommendationsController < ApplicationController

  def search

    @user = User.first

    @user.refresh_access_token

    header = {
      Authorization: "Bearer #{@user.access_token}"
    }

    artist_search = RestClient.get("https://api.spotify.com/v1/search?q=#{params[:q]}&type=artist", header)

    artist_response = JSON.parse(artist_search.body)

    artist_id = artist_response["artists"]["items"][0]["id"]

    recommendation_search = RestClient.get("https://api.spotify.com/v1/artists/#{artist_id}/related-artists", header)

    recommendation_results = JSON.parse(recommendation_search.body)

    recommended_artist_ids = recommendation_results["artists"].map{|artist| artist["id"]}

    artists_object = {

      searched_artist: artist_response,
      recommended_artists: recommendation_results

    }

    render json: artists_object

  end

  def search_on_click

    @user = User.first

    @user.refresh_access_token

    header = {
      Authorization: "Bearer #{@user.access_token}"
    }

    recommendation_search = RestClient.get("https://api.spotify.com/v1/artists/#{params[:q]}/related-artists", header)

    recommendation_results = JSON.parse(recommendation_search.body)

    artists_object = {
      recommended_artists: recommendation_results
    }

    render json: artists_object

  end

end
