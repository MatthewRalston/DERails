# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
 Rails.application.config.assets.precompile += %w( correlation.js correlation.css maplot.js maplot.css pca.js pca.css expression_clustering.js expression_clustering.css d3.v3.min.js d3.slider.js d3.slider.css jquery.js simple_statistics.js canvasXpress.min.js)
