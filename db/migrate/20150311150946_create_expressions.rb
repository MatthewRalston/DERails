class CreateExpressions < ActiveRecord::Migration
  def up
    create_table :expressions do |t|
      t.string :gene, limit: 10
      t.integer :time
      t.string :condition, limit: 10
      t.integer :replicate
      t.float :expression
    end
  end
  def down
    drop_table :expressions
  end
end
