class AddSubToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :Sub, :string
  end
end
