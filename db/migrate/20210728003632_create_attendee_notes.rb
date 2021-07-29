# frozen_string_literal: true

class CreateAttendeeNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :attendee_notes do |t|
      t.text :note
      t.string :note_type
      t.references :attendee, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
