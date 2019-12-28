class AddColumnToWatchlistEpisodes < ActiveRecord::Migration[6.0]
  def change
    add_column :watchlist_episodes, :watched, :boolean, :default => false
  end
end
