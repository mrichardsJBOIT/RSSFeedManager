class CreateEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :entries do |t|
      t.references :feed, null: false, foreign_key: true
      t.string :title
      t.string :url
      t.string :author
      t.datetime :published_at
      t.text :content
      t.string :guid

      t.timestamps
    end
  end
end
