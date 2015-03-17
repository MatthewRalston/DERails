class CreateExpressiondifferences < ActiveRecord::Migration
  def up
    create_table :expressiondifferences do |t|
      t.string :gene
      t.string :time1
      t.string :condition1
      t.string :time2
      t.string :condition2
      t.float :foldchange
      t.float :pval

      t.timestamps null: false
    end
  end
  def down
    drop table :expressiondifferences
  end
end
