class AddTypeToCars < ActiveRecord::Migration[7.1]
  def change
    add_reference :cars, :type, null: false, foreign_key: true
  end
end
