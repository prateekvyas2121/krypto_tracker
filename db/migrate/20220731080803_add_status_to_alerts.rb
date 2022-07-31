class AddStatusToAlerts < ActiveRecord::Migration[6.1]
  def change
    add_column :alerts, :status, :integer, default: 0
  end
end
