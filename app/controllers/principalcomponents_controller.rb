class PrincipalcomponentsController < ApplicationController
  def pca
    rawdata = Principalcomponent.all.map{|x| x.as_json}

    stress = rawdata.map{|x| x["condition"]}
    time = rawdata.map{|x| x["time"]}
    replicate = rawdata.map{|x| x["replicate"]}

    data = rawdata.map{|x| [x["pc1"],x["pc2"],x["pc3"]]}
    @pca = {"z" => {"Annt1"=>time,"Annt2"=>stress,"Annt3"=>replicate},
      "x" => {"Factor2" => ["Unstressed","Butanol","Butyrate"],
        "Factor1"=> ["15min","75min","150min","270min"]},
      "y" => {"vars"=>rawdata.map{|x|[x["condition"],x["replicate"],x["time"]].join("_")},
        "smps"=>["PC1","PC2","PC3"],
        "data"=>data},
      "a" => {"xAxis" => ["15min","75min"],
        "xAxis2" => ["150min","270min"]}
      }
  end
end
