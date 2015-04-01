function pca() {

  var pcacanvas = new CanvasXpress("canvas3",
          data,
          {"colorBy": "Annt2",
           "graphType": "Scatter3D",
           "xAxis": ["PC1"],
           "yAxis": ["PC2"],
           "zAxis": ["PC3"]
          }
        );
}
