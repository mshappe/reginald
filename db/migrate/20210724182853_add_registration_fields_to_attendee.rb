class AddRegistrationFieldsToAttendee < ActiveRecord::Migration[6.1]
  def change
    add_column :attendees, :transaction_id, :integer
    add_column :attendees, :registered_at, :datetime
  end
end
