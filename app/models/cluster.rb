class Cluster < ActiveRecord::Base
  validates :group, presence: true
  validates :silhouette, presence: true
  validates :dbi, presence: true
  validates :dunn, presence: true
end
