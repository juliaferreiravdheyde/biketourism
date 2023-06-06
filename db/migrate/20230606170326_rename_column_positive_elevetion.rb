class RenameColumnPositiveElevetion < ActiveRecord::Migration[7.0]
  def change
    rename_column :routes, :positive_elevetion, :positive_elevation
  end
end
