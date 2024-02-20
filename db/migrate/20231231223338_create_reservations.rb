class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true
      t.date :pickup_date
      t.date :return_date
      t.float :total_price
      t.string :status

      t.timestamps
    end
  end
end
