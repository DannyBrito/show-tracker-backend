class CreateWatchlistEpisodes < ActiveRecord::Migration[6.0]
  def change
    create_table :watchlist_episodes do |t|
      t.integer :episode_id
      t.integer :watchlist_id
      t.integer :rating

      t.timestamps
    end
  end
end
