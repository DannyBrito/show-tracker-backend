class Api::V1::TvShowsController < ApplicationController

    def show # used for retriving data from primary API
        tv_show = TvShow.find_by(id: params[:id])
        tv_show = TvShowSerializer.new(tv_show).serialized_json
        render :json => tv_show
    end
    
    def search_and_save 
        tv_shows = TvShow.where("lower(name) LIKE LOWER('%#{purify_string}%')")
        if(tv_shows.length == 0)
            api_tv_shows = RestClient.get "#{ENV['MVDB_BASE']}search/tv?api_key=#{ENV['MV_KEY']}&language=en-US&query=#{params[:query]}", {accept: :json}
            api_tv_shows = JSON.parse(api_tv_shows)
            tv_shows = api_tv_shows['results'].map{|ts| save_new_entry(ts)}
        end
        tv_shows = TvShowSerializer.new(tv_shows).serialized_json
        render :json => tv_shows
    end

    private

    def purify_string # used to check if saved on primary api
        params[:query].gsub('+',' ')
    end

    def save_new_entry(ts)
        TvShow.create(name: ts['name'],poster_path: ts['poster_path'],api: ts['id'])
    end

end
