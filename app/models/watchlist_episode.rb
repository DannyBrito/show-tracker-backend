class WatchlistEpisode < ApplicationRecord
    belongs_to :watchlist
    belongs_to :episode
    
end
