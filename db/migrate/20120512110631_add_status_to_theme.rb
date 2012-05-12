class AddStatusToTheme < ActiveRecord::Migration
  def change
    add_column :themes, :status, :string, :default => nil
  end
end
