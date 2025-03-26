class CreateTablePlans < ActiveRecord::Migration[7.2]
  def change
    create_table :plans do |t|
      t.timestamps
      t.datetime :date
      t.belongs_to :trip, index: true
      t.string :title
      t.float :budget
      t.string :hotel
      t.text :description
    end
  end
end
