class Watchlist < ApplicationRecord
    belongs_to :user
    has_many :watchlist_episodes
    has_many :episodes, through: :watchlist_episodes
    has_many :tv_shows, through: :episodes
end
