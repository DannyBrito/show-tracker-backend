class Api::V1::WatchlistEpisodesController < ApplicationController
    before_action :set_user_watchlist

    def update #this route is not restful as param/:id is not for watchlist_episode but for episode
        episode = WatchlistEpisode.find_by(episode_id:params[:id],watchlist_id:@current_watchlist.id)
        episode.update(watchlist_episode_params)
        render :json => episode
    end

    def destroy # param/:id refering to 
        WatchlistEpisode.destroy_by(watchlist_id:@current_watchlist.id,tv_show_id:params[:id])
        render :json => {message:'success'}
    end

    private

    def set_user_watchlist
        #currently hardcoded for testing purposes and authentification need to be fully implemented
        @current_watchlist = Watchlist.find(4)
    end

    def watchlist_episode_params
        params.require(:watchlist_episode).permit(:rating,:watched)
    end
end
