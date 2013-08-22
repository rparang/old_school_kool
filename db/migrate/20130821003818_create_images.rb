class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :url
      t.integer :width
      t.integer :height
      t.decimal :aspect_ratio
      t.string :reddit_title
      t.string :reddit_author
      t.string :reddit_permalink
      t.string :reddit_thumbnail_url

      t.timestamps
    end
  end
end
