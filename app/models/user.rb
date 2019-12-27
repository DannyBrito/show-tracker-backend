class User < ApplicationRecord
    has_one :watchlist, dependent: :destroy 
    after_create :build_watchlist

    private

    def build_watchlist
        Watchlist.create(user: self)
        true
    end
end
