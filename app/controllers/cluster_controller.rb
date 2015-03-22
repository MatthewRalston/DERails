class ClusterController < ApplicationController
  def initialize
    @times = %w(15 75 150 270)
    @conditions = %w(Untreated Butyrate Butanol)
  end

  def expression_clustering
    # M E T R I C    S E L E C T I O N
    metric = "silhouette"

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
    @matrix = []
    @clusters.each_with_index do |cluster,i|
      row = Array.new(@clusters.size,cluster[metric])
      row[i] = 0
      @matrix << row
    end
  end

  def average(expressions)
    #return (expressions.reduce(:*)**(1.to_f/expressions.size)).round(2)
    return (expressions.reduce(:+)/expressions.size).round(2) # Geometric acerage
  end
end
