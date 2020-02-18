class Api::V1::TvshowsController < ApplicationController

    def index #need to change to auto
        user = User.find(params[:id])
        render :json => {tv_shows:user.tvshows, user: user}
    end

    def search
        api_tv_shows = RestClient.get "#{ENV['MVDB_BASE']}search/tv?api_key=#{ENV['MV_KEY']}&language=en-US&query=#{params[:query]}", {accept: :json}
        api_tv_shows = JSON.parse(api_tv_shows)
        tv_shows = api_tv_shows['results'].map{|ts|{id: ts['id'],name:ts['name'],poster_path:ts['poster_path'], overview: ts['overview']}}

        render :json => tv_shows
    end

    def popular
        api_tv_shows=RestClient.get "#{ENV['MVDB_BASE']}tv/popular?api_key=#{ENV['MV_KEY']}&language=en-US", {accept: :json}
        api_tv_shows = JSON.parse(api_tv_shows)
        api_tv_shows = api_tv_shows['results'].map{|ts|{id: ts['id'],name:ts['name'],poster_path:ts['poster_path'], overview: ts['overview']}}
        render :json => api_tv_shows
    end

    def add_tv_show
        api_tv_show = RestClient.get "#{ENV['MVDB_BASE']}tv/#{params[:id]}?api_key=#{ENV['MV_KEY']}", {accept: :json}
        api_tv_show = JSON.parse(api_tv_show)
        current_ts = Tvshow.create(name: api_tv_show['name'],poster_path: api_tv_show['poster_path'],api: api_tv_show['id'],overview:api_tv_show['overview'], num_seasons:api_tv_show['number_of_seasons'],user: current_user)
        if current_ts.valid?
            render :json => current_ts, status: :ok
        else
            render :json => {message: "no created"}, status: :bad
        end
    end

    def destroy
        deleted = Tvshow.destroy(params[:id])

        render :json =>{id:deleted.id, message: 'tv show succesfully deleted'},status: :ok
    end

end
