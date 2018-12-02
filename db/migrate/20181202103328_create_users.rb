# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: false do |t|
      t.string :id, limit: 36, null: false, primary_key: true
      t.string :email, null: false

      t.index :email, unique: true

      t.timestamps
    end
  end
end
