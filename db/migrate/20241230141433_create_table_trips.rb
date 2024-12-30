class CreateTableTrips < ActiveRecord::Migration[7.2]
  def change
    create_table :table_trips do |t|
      t.timestamps
      t.belongs_to :user, index: true
      t.string :title
      t.datetime :date
    end
  end
end
  