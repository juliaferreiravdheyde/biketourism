class AddRouteRefToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :pinned_route, foreign_key: { to_table: :routes }
  end
end
