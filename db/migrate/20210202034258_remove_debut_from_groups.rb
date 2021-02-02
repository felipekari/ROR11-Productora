class RemoveDebutFromGroups < ActiveRecord::Migration[5.2]
  def change
    remove_column :groups, :debut, :date
  end
end
