class CreateEpisodes < ActiveRecord::Migration[6.0]
  def change
    create_table :episodes do |t|
      t.integer :episode_number
      t.integer :tv_show_id
      t.integer :season
      t.string :name
      t.string :api
      t.text :overview

      t.timestamps
    end
  end
end
