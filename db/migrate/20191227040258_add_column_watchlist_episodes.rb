class AddColumnWatchlistEpisodes < ActiveRecord::Migration[6.0]
  def change
    add_column :watchlist_episodes, :tv_show_id, :integer
  end
end
