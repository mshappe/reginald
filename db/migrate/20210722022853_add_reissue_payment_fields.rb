class AddReissuePaymentFields < ActiveRecord::Migration[6.1]
  def change
    add_column :attendees, :reissued_twice_pay_type, :string
    add_column :attendees, :reissued_thrice_pay_type, :string
    add_column :attendees, :last_chance_pay_type, :string
  end
end
