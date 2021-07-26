# frozen_string_literal: true

class AddAasmStateToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :attendees, :aasm_state, :string
  end
end
