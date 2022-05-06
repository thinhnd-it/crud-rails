class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :phone, :string
    add_column :users, :dob, :datetime
    add_column :users, :name, :string
  end
end
