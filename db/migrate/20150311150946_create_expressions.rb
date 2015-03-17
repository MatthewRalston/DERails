class CreateExpressions < ActiveRecord::Migration
  def change
    create_table :expressions do |t|
      t.string :gene
      t.string :time
      t.string :condition
      t.integer :replicate
      t.float :expression

      t.timestamps null: false
    end
  end
end
