class AddRouteRefToRides < ActiveRecord::Migration[7.0]
  def change
    add_reference :rides, :routes, null: false, foreign_key: true
  end
end
