class CreatePoints < ActiveRecord::Migration[7.0]
  def change
    create_table :points do |t|
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.references :route, null: false, foreign_key: true

      t.timestamps
    end
  end
end
