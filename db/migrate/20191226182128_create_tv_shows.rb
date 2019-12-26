class CreateTvShows < ActiveRecord::Migration[6.0]
  def change
    create_table :tv_shows do |t|
      t.string :name
      t.string :poster_path
      t.integer :seasons
      t.string :api

      t.timestamps
    end
  end
end
