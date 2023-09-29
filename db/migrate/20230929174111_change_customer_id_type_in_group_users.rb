class ChangeCustomerIdTypeInGroupUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :group_users, :customer_id, :bigint
  end
end
