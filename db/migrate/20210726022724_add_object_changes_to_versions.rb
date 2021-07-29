# frozen_string_literal: true

class AddObjectChangesToVersions < ActiveRecord::Migration[6.1]
  def change
    add_column :versions, :object_changes, :text
  end
end
