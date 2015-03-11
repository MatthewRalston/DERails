class CreateClusters < ActiveRecord::Migration
  def change
    create_table :clusters do |t|
      t.int :group
      t.string :gene
      t.float :silhouette

      t.timestamps null: false
    end
  end
end
