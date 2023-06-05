class CreateRides < ActiveRecord::Migration[7.0]
  def change
    create_table :rides do |t|
      t.datetime :time
      t.date :date

      t.timestamps
    end
  end
end
