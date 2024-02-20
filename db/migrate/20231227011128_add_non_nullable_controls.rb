class AddNonNullableControls < ActiveRecord::Migration[7.1]
  def change
    change_column_null :cars, :marca, false
    change_column_null :cars, :modelo, false
    change_column_null :cars, :capacidad, false
    change_column_null :cars, :transmision, false
    change_column_null :cars, :anio, false
    change_column_null :cars, :preciodiario, false
  end
end
