class Api::V1::WatchlistsController < ApplicationController
    #the concept - for authentification that I'm assuming is where the user will be identify and access direct to its watchlist
    def show
        watchlist = Watchlist.find(params[:id])
        
        render :json => watchlist.get_attributes
    end
end
