class CreateGenes < ActiveRecord::Migration
  def up
    create_table :genes do |t|
      t.string :gene, limit: 10
      t.integer :group
      t.string :url

    end
  end
  def down
    drop_table :genes
  end
end
