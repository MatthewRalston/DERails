class ExpressionController < ApplicationController

  def initialize
    @times = %w(15 75 150 270)
    @conditions = %w(Untreated Butyrate Butanol)
    @replicates = [1,2,3]
  end

  def maplot
  end

  def correlation
    puts(params)
    @errors = []
    if params[:time]
      checkparams(params)
      unless @errors.any? 
        @dataset=Expression.select("gene, expression, replicate").where(time: params[:time], condition: params[:condition])
          .map{|r| r=r.as_json.compact; r["expression"]+=1; r}
          .group_by{|r| r["gene"]}
          .map{|gene,vals|
          reps=vals.map{|x|x["replicate"]}
          exps=vals.map{|x|x["expression"]}
          {"gene"=>gene,"rep1"=>reps[0],"rep2"=>reps[1],"exp1"=>exps[0],"exp2"=>exps[1]}
        }
      end
    end
  end

  private
  def checkparams(params)
    @errors << "Invalid time parameter: \"#{params[:time]}\"" unless @times.include?(params[:time])
    @errors << "Invalid condition parameter: \"#{params[:condition]}\"" unless @conditions.include?(params[:condition])
    @errors << "Invalid replicate 1: \"#{params[:replicate1]}\"" unless @replicates.include?(params[:replicate1].to_i)
    @errors << "Invalid replicate 2: \"#{params[:replicate2]}\"" unless @replicates.include?(params[:replicate2].to_i)
  end
  
end
