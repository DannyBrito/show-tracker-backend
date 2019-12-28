class Api::V1::WatchlistsController < ApplicationController
    #the concept - for authentification that I'm assuming is where the user will be identify and access direct to its watchlist
    def show # check how to render own watchlist
        to_locate = params[:id]
    
        #need to implement how to look for own watchlist
        # if to_locate == 'self'
        #     to_locate = 4
        # end

        watchlist = Watchlist.find(to_locate)
        render :json => watchlist.get_attributes
    end
end
