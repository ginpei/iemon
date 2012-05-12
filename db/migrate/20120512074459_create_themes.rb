class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :body
      t.date :target_date

      t.timestamps
    end
  end
end
