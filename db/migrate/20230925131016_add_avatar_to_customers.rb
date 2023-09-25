class AddAvatarToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :avatar, :string
  end
end
