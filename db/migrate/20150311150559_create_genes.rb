class CreateGenes < ActiveRecord::Migration
  def change
    create_table :genes do |t|
      t.string :gene
      t.string :url

      t.timestamps null: false
    end
  end
end
