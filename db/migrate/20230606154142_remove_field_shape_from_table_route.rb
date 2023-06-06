class RemoveFieldShapeFromTableRoute < ActiveRecord::Migration[7.0]
  def change
    remove_column :routes, :shape, :string
  end
end
