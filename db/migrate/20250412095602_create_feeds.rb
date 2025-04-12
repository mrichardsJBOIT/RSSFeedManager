class CreateFeeds < ActiveRecord::Migration[8.0]
  def change
    create_table :feeds do |t|
      t.string :url
      t.string :name
      t.text :description
      t.datetime :last_fetched_at

      t.timestamps
    end
  end
end
