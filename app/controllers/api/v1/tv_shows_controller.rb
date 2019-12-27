class Api::V1::TvShowsController < ApplicationController

    def show # used for retriving data from primary API
        tv_show = TvShow.find_by(id: params[:id])

        
        # tv_show = TvShowSerializer.new(tv_show,{include:[:episodes]}).serialized_json
        # feature to implement better where using serializer
        render :json => tv_show.get_attributes
    end
    
    def search_and_save 
        tv_shows = TvShow.where("lower(name) LIKE LOWER('%#{purify_string}%')")

        if(tv_shows.length == 0)
            api_tv_shows = RestClient.get "#{ENV['MVDB_BASE']}search/tv?api_key=#{ENV['MV_KEY']}&language=en-US&query=#{params[:query]}", {accept: :json}
            api_tv_shows = JSON.parse(api_tv_shows)
            tv_shows = api_tv_shows['results'].map{|ts| save_new_entry(ts)}
        end
            tv_shows = tv_shows.map{|ts| ts.get_attributes}

        # tv_shows = TvShowSerializer.new(tv_shows,{include:[:episodes]}).serialized_json
        # need to improve and use serializers?

        render :json => tv_shows
    end
    
    private
    
    def purify_string # used to check if saved on primary api
        params[:query].gsub('+',' ')
    end

    def save_new_entry(ts) #save tv-show
        
        current_ts = TvShow.create(name: ts['name'],poster_path: ts['poster_path'],api: ts['id'])
       
        #new to create episodes and link these to the tv-show
        
        api_tv_show = RestClient.get "#{ENV['MVDB_BASE']}tv/#{current_ts.api}?api_key=#{ENV['MV_KEY']}&append_to_response=season/1,season/2,season/3,season/4,season/5,season/6,season/7,season/8,season/9,season/10,season/11,season/12,season/13,season/14,season/15,season/16,season/17,season/18,season/19,season/20", {accept: :json}
        api_tv_show = JSON.parse(api_tv_show)
        current_ts[:seasons] = api_tv_show['number_of_seasons']
        
        
        c_season = 1
        
        while(c_season <= current_ts[:seasons]) do
            api_tv_show["season/#{c_season}"]['episodes'].each{|ep| add_episodes_to_ts(ep,current_ts.id)}
            c_season += 1
        end
        
        #save current number of seasons and return new tv-show implicit

        current_ts.save
    end
    
    def add_episodes_to_ts(episode, tv_show_id)
        Episode.create(episode_number: episode['episode_number'],tv_show_id:tv_show_id,season:episode['season_number'],api:episode['id'],name:episode['name'],overview:episode['overview'])
    end
end
