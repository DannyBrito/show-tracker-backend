class Episode < ApplicationRecord
    belongs_to :tv_show
    has_many :watchlist_episodes
end
