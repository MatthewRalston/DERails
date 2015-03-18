class CreateExpressiondifferences < ActiveRecord::Migration
  def up
    create_table :expressiondifferences do |t|
      t.string :gene, limit: 10
      t.integer :time1
      t.string :condition1, limit: 10
      t.integer :time2
      t.string :condition2, limit: 10
      t.float :foldchange
      t.float :pval

    end
  end
  def down
    drop table :expressiondifferences
  end
end
