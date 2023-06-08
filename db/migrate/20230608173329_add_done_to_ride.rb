class AddDoneToRide < ActiveRecord::Migration[7.0]
  def change
    add_column :rides, :done, :boolean, default: false
  end
end
