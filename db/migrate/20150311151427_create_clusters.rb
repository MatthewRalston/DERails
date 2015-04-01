class CreateClusters < ActiveRecord::Migration
  def up
    create_table :clusters do |t|
      t.integer :group
      t.integer :stress_response
      t.integer :time_response
      t.float :silhouette
      t.float :dbi
      t.float :dunn
      t.float :intra_dissim
      t.text :centroid
      t.text :all_silhouettes
      t.text :goterms
    end
  end

  def down
    drop_table :clusters
  end
end
