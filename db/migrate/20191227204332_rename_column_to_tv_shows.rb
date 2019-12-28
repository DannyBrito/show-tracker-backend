class RenameColumnToTvShows < ActiveRecord::Migration[6.0]
  def change
    rename_column :tv_shows, :seasons, :num_seasons
  end
end
