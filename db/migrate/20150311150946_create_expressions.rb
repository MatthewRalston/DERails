class CreateExpressions < ActiveRecord::Migration
  def change
    create_table :expressions do |t|
      t.string :gene
      t.string :time
      t.string :condition
      t.int :replicate
      t.float :expression

      t.timestamps null: false
    end
  end
end
