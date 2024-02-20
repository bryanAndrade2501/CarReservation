class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.string :modelo
      t.string :marca
      t.string :transmision
      t.integer :anio
      t.integer :capacidad
      t.float :preciodiario

      t.timestamps
    end
  end
end
