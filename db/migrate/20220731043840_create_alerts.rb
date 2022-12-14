# frozen_string_literal: true

class CreateAlerts < ActiveRecord::Migration[6.1]
  def change
    create_table :alerts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :price
      t.timestamps
    end
  end
end
