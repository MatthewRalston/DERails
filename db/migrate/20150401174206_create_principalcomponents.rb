class CreatePrincipalcomponents < ActiveRecord::Migration
  def change
    create_table :principalcomponents do |t|
      t.string :condition, limit: 10
      t.integer :replicate
      t.integer :time
      t.float :pc1
      t.float :pc2
      t.float :pc3

    end
  end
end
