class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :members
      t.date :debut
      t.integer :gender

      t.timestamps
    end
  end
end
