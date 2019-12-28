class Api::V1::WatchlistEpisodesController < ApplicationController
    before_action :set_user_watchlist

    def update #this route is not restful
        WatchlistEpisode.find_by(episode_id:params[:id],watchlist_id:@current_watchlist)
    end

    private

    def set_user_watchlist
        #currently hardcoded for testing purposes and authentification need to be fully implemented
        @current_watchlist = Watchlist.find(4)
    end
end
