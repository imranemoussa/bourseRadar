class ChangeRoleToBeStringInUsers < ActiveRecord::Migration[8.0]
  def change
    change_column :users, :role, :string
  end
end
