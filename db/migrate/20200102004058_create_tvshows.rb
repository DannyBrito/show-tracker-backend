class CreateTvshows < ActiveRecord::Migration[6.0]
  def change
    create_table :tvshows do |t|
      t.integer :user_id
      t.string :name
      t.string :poster_path
      t.string :api
      t.integer :num_seasons
      t.text :overview

      t.timestamps
    end
  end
end
