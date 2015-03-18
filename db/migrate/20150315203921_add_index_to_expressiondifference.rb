class AddIndexToExpressiondifference < ActiveRecord::Migration
  def up
    add_index :expressiondifferences, [:gene, :time1, :time2, :condition1, :condition2], unique: true, name: "diff_exp"
  end

  def down
    remove_index :expressiondifferences, name: "diff_exp"
  end
end
