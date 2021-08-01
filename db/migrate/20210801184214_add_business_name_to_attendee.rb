class AddBusinessNameToAttendee < ActiveRecord::Migration[6.1]
  def change
    add_column :attendees, :business_name, :string
  end
end
