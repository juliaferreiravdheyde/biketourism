class RenameColumnRoutesId < ActiveRecord::Migration[7.0]
  def change
    rename_column :rides, :routes_id, :route_id
  end
end
