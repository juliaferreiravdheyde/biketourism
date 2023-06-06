class CreateRoutes < ActiveRecord::Migration[7.0]
  def change
    create_table :routes do |t|
      t.string :name
      t.text :description
      t.string :type_of_route
      t.string :shape
      t.float :positive_elevetion

      t.timestamps
    end
  end
end
