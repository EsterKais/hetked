# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles, id: false do |t|
      t.string :id, limit: 36, null: false, primary_key: true

      t.string :firstname
      t.string :lastname
      t.string :username
      t.datetime :birthday

      t.string :user_id, index: true

      t.timestamps
    end
  end
end
