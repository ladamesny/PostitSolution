class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :url
      t.text :title
      t.text :description
      t.timestamps
    end
  end
end
