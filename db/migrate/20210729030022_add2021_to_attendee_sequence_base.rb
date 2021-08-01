class Add2021ToAttendeeSequenceBase < ActiveRecord::Migration[6.1]
  def change
    Attendee.connection.execute(
      """
      ALTER SEQUENCE #{Attendee.table_name}_id_seq RESTART WITH 2021
      """
    )
  end
end
