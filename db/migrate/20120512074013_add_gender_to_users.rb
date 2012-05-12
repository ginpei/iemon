class AddGenderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string
    add_column :users, :age, :string
    add_column :users, :job, :string
  end
end
