# frozen_string_literal: true

class RenameThriseByToThriceBy < ActiveRecord::Migration[6.1]
  def change
    rename_column :attendees, :reissued_thrise_by, :reissued_thrice_by
  end
end
