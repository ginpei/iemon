class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :theme
      t.belongs_to :user
      t.string :body

      t.timestamps
    end
    add_index :posts, :theme_id
    add_index :posts, :user_id
  end
end
