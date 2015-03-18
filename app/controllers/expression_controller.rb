class ExpressionController < ApplicationController

  def initialize
    @times = %w(15 75 150 270)
    @conditions = %w(Untreated Butyrate Butanol)
    @replicates = [1,2,3]
  end

  def correlation
    puts(params)
    @errors = []
    if params[:time]
      check_correlation_params(params)
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

  def maplot
    puts(params)
    @errors = []
    if params[:time1]
      check_maplot_params(params)
      unless @errors.any?
        @dataset = diffexp_query(params).map{|x| x.as_json.compact}.group_by{|x| x["gene"]}.map{|gene,vals| exps = vals.map{|x| x["expression"] + 1}; {"gene"=>gene,"foldchange"=>vals[0]["foldchange"],"pval"=>vals[0]["pval"],"expression"=>exps.reduce(:+)/exps.size.to_f}}
      end
    end
  end

  private
  def diffexp_query(params)
    query = "INNER JOIN expressions ON expressiondifferences.gene = expressions.gene AND expressiondifferences.time1 = expressions.time AND expressiondifferences.condition1 = expressions.condition"
    dataset = if params[:time1] == "" && params[:time2] == ""
                Expressiondifference.joins(query).where(condition1: params[:condition1], condition2: params[:condition2]).select("expressions.expression,expressions.gene,expressiondifferences.foldchange,expressiondifferences.pval")
              elsif params[:condition1] == "" && params[:condition2] == ""
                Expressiondifference.joins(query).where(time1: params[:time1], time2: params[:time2]).select("expressions.expression,expressions.gene,expressiondifferences.foldchange,expressiondifferences.pval")
              else
                Expressiondifference.joins(query).where(time1: params[:time1], time2: params[:time2], condition1: params[:condition1], condition2: params[:condition2]).select("expressions.expression,expressions.gene,expressiondifferences.foldchange,expressiondifferences.pval")
              end
    dataset
  end

  def check_correlation_params(params)
    @errors << "Invalid time parameter: \"#{params[:time]}\"" unless @times.include?(params[:time])
    @errors << "Invalid condition parameter: \"#{params[:condition]}\"" unless @conditions.include?(params[:condition])
    @errors << "Invalid replicate 1: \"#{params[:replicate1]}\"" unless @replicates.include?(params[:replicate1].to_i)
    @errors << "Invalid replicate 2: \"#{params[:replicate2]}\"" unless @replicates.include?(params[:replicate2].to_i)
  end

  def check_maplot_params(params)
    @errors << "Invalid time #1: \"#{params[:time1]}\"" unless params[:time1] == "" || @times.include?(params[:time1])
    @errors << "Invalid condition #1: \"#{params[:condition1]}\"" unless params[:condition1] == "" || @conditions.include?(params[:condition1])
    @errors << "Invalid time #2: \"#{params[:time2]}\"" unless params[:time2] == "" || @times.include?(params[:time2])
    @errors << "Invalid condition #2: \"#{params[:condition2]}\"" unless params[:condition2] == "" || @conditions.include?(params[:condition2])

    if params[:time1] == "" || params[:time2] == ""
      @errors << "Invalid pair of times:\nTime 1 - #{params[:time1]}\nTime 2 - #{params[:time2]}\nTime points must both be blank or both non-blank." unless params[:time2] == "" && params[:time2] == ""
    elsif params[:condition1] == "" || params[:condition2] == ""
      @errors << "Invalid pair of conditions:\nCondition 1 - #{params[:condition1]}\nCondition 2 - #{params[:condition2]}\nConditions must both be blank or both non-blank." unless params[:condition1] == "" && params[:condition2] == ""
    end
  end
  
end
