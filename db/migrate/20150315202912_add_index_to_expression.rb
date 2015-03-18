class AddIndexToExpression < ActiveRecord::Migration
  def up
    add_index :expressions, [:gene, :time, :condition]
  end
  def down
    remove_index :expressions, column: [:gene, :time, :condition]
  end
end
