require 'matrix'

class ClusterController < ApplicationController
  def initialize
    @times = %w(15 75 150 270)
    @conditions = %w(Untreated Butyrate Butanol)
  end

  def expression_clustering
    # M E T R I C    S E L E C T I O N
    #metric = params[:metric]
    metric = "recip_dbi"

    @clusters = Cluster.all.map{|x|x.as_json}
    @genes = Expression.joins("INNER JOIN genes on expressions.gene = genes.gene").select("genes.gene,genes.group,expressions.time,expressions.condition,expressions.expression")
      .map{|x| x.as_json}
      .group_by{|x| x["gene"]}
      .map do |gene,reps|
      data = reps.group_by{|x| x["condition"]}
      data.each do |cond,genes|
        data[cond]=genes.group_by{|x| x["time"]}
          .map{|k,v|
          {k=>average(v.map{|x|x["expression"]})}
        }.reduce(:merge)
      end
      {gene: reps[0]["gene"], group: reps[0]["group"], profile: data}
    end
    @matrix = self.send(metric,@clusters)
  end
  private
  def average(expressions)
    #return (expressions.reduce(:*)**(1.to_f/expressions.size)).round(2)
    return (expressions.reduce(:+)/expressions.size).round(2) # Geometric acerage
  end

  def get_centroid(cluster)
    cluster["centroid"].split(";").map{|x|x.to_f}
  end

  # Calculates the euclidean distance between two vectors
  #
  # @param c1
  def euclidean_dist(c1,c2)
    Math.sqrt(c1.zip(c2).map{|p| (p[1]-p[0])**2}.reduce(:+))
  end

  def recip_dbi(clusters)
    n=clusters.size
    Matrix.build(n,n) do |r,c|
      euclidean_dist(*[clusters[r],clusters[c]].map{|x| get_centroid(x)}) / clusters[r]["intra_dissim"]
    end.to_a
  end

  def silhouettes(clusters)
    Array.new(clusters.size){|x| clusters[x]["all_silhouettes"].split(";").map{|y|y.to_f}}
  end

end
