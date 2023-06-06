class AddLatitudeAndLongitudeToPoints < ActiveRecord::Migration[7.0]
  def change
    add_column :points, :latitude, :float
    add_column :points, :longitude, :float
  end
end
