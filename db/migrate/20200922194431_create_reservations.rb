class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :date
      t.datetime :time
      t.string :vehicle_type
      t.string :pick_up
      t.string :drop_off
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
