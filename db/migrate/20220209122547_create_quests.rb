# frozen_string_literal: true

class CreateQuests < ActiveRecord::Migration[7.0]
  def change
    create_table :quests do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
