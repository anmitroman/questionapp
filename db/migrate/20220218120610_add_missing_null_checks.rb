class AddMissingNullChecks < ActiveRecord::Migration[7.0]
  def change
    change_column_null :quests, :title, false
    change_column_null :quests, :body, false
    change_column_null :answers, :body, false
  end
end
