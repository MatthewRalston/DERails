class CreateClusters < ActiveRecord::Migration
  def up
    create_table :clusters do |t|
      t.integer :group
      t.string :gene, limit: 10
      t.float :silhouette

    end
  end

  def down
    drop_table :clusters
  end
end
