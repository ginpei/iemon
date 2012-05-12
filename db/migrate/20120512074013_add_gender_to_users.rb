class AddGenderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string
    add_column :users, :age, :stirng
    add_column :users, :job, :stirng
  end
end
