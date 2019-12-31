# Overview
This page contains all of the code used to built the machine learning models as well as the links to the datasets used to train them.

# Datasets

## Crop Disease Detection

- https://www.kaggle.com/vipoooool/new-plant-diseases-dataset

## Weed Detection

- https://www.kaggle.com/fpeccia/weed-detection-in-soybean-crops

## Crop Price Prediction

- https://www.kaggle.com/raghu07/vegetable-and-fruits-price-in-india

## Best Crop Prediction

Dataset was produced by aggregating relevant statistics from several reputable websites:

### Corn

- https://www.farmprogress.com/corn/high-temperature-effects-corn-soybeans
- https://www.ecofarmingdaily.com/grow-crops/grow-corn/soil-requirements/
- https://homeguides.sfgate.com/ideal-climate-soil-corn-growth-37426.html
- https://homeguides.sfgate.com/minerals-corn-needs-47173.html
- https://www.extension.purdue.edu/extmedia/NCH/NCH-40.html
- http://www.agrometeorology.org/files-folder/repository/chapter13A_gamp.pdf
- http://agron-www.agron.iastate.edu/courses/Agron541/classes/541/lesson01a/1a.3.html

### Cotton

- https://wikifarmer.com/cotton-growing-conditions/
- https://www.hunker.com/13426605/types-of-soil-for-cotton-plants
- https://www.cotton.org/tech/ace/soil-fertility.cfm
- https://www.agprofessional.com/article/cotton-nutrition-and-fertilization-0
- http://www.agrometeorology.org/files-folder/repository/chapter13A_gamp.pdf
- https://mospace.umsystem.edu/xmlui/bitstream/handle/10355/54923/AESbulletin.pdf?sequence=1

### Rice

- https://www.hindawi.com/journals/ija/2014/846707/
- https://www.reference.com/business-finance/climate-growing-rice-48bfc2ebc0345794
- https://www.southernexposure.com/blog/2017/08/guide-to-growing-rice/
- https://www.cropnutrition.com/efu-soil-ph
- http://www.ricehub.org/RT/nutrients/
- http://www.yourarticlelibrary.com/cultivation/cultivation-of-rice-suitable-conditions-required-for-the-cultivation-of-rice-6-conditions/25491
- https://www.researchgate.net/publication/271922090_Effect_of_rice_growth_stage_temperature_relative_humidity_and_wetness_duration_on_infection_of_rice_panicles_by_Villosiclava_virens

### Soybean

- https://www.hunker.com/12437296/what-is-the-best-climate-for-growing-soybeans
- https://www.hunker.com/12331572/what-types-of-soil-do-soybeans-grow-the-best-in
- https://www.canr.msu.edu/news/managing_soil_ph_for_optimal_soybean_production
- https://lib.dr.iastate.edu/cgi/viewcontent.cgi?article=1191&context=extension_ag_pubs
- https://cropwatch.unl.edu/2018/enhancing-soybean-storage-starts-harvest-moisture


### Peanuts

- https://living.thebump.com/good-climate-growing-peanuts-5973.html
- https://garden.org/learn/articles/view/477/
- http://corn.agronomy.wisc.edu/Crops/Peanut.aspx
- https://www.farmprogress.com/attention-peanut-nutrition-needs-critical-higher-fertilizer-prices-0
- https://www.agrocrops.com/blog_detail/17/peanut-farming
- https://www.peanutsusa.com/phocadownload/GMPs/2009%20Final%20Chapter%205%20Shelled%20Goods%20Cold%20Storage%20-%20Approved%2011-6-09.pdf

### Wheat

- https://kids.britannica.com/students/article/wheat/277720/210174-toc
- https://homeguides.sfgate.com/importance-of-loamy-soil-for-growing-wheat-13406934.html
- Soil and Nutrient Management for Wheat - WestBred
- https://www.cropnutrition.com/winter-wheat-fertilization
- http://agropedia.iitk.ac.in/content/rainfall-climatic-requirement-wheat

### Beans

- https://extension.uga.edu/publications/detail.html?number=C1006&title=Home%20Garden%20Green%20Beans
- https://www.motherearthnews.com/organic-gardening/growing-beans-zmaz09jjzraw
- https://homeguides.sfgate.com/soil-types-green-beans-25141.html
- https://garden.org/learn/articles/view/448/
- https://garden.org/learn/articles/view/454/
- https://homeguides.sfgate.com/weather-affects-bean-plants-56711.html
- http://agriculture.infoagro.com/crops/bean-growing--part-i-/
 
### Broccoli

- https://bonnieplants.com/how-to-grow/growing-broccoli/
- https://harvesttotable.com/how_to_grow_broccoli/
- https://www.almanac.com/plant/broccoli
- https://www.goodhousekeeping.com/home/gardening/a20706315/growing-broccoli/
- https://bonnieplants.com/how-to-grow/growing-broccoli/
- https://www.hydroponics-simplified.com/how-to-grow-hydroponics.html

### Potato

- https://harvesttotable.com/how_to_grow_potatoes/
- https://homeguides.sfgate.com/kind-soil-potatoes-like-70919.html
- http://www.gardening.cornell.edu/homegardening/scenec6be.html
- https://homeguides.sfgate.com/kind-fertilizer-needed-potato-plants-56645.html
- http://blog.seedsavers.org/blog/tips-for-growing-potatoes
- https://spudman.com/article/humidity-control-key-to-storing-bulk-potatoes/

### Banana

- https://www.tropicalpermaculture.com/growing-bananas.html
- https://www.crfg.org/pubs/ff/banana.html
- https://www.gardeningknowhow.com/edible/fruits/banana/feeding-banana-plants.htm
- https://www.haifa-group.com/banana-fertilizer/crop-guide-growing-banana

### Onion

- https://harvesttotable.com/bulb-onion-growing-day-length-and-temperature/
- https://www.quickcrop.ie/learning/plant/onion
- https://homeguides.sfgate.com/ph-level-growing-onions-42823.html
- https://www.yara.co.uk/crop-nutrition/onion/onion-nutritional-summary/
- https://www.almanac.com/plant/onions
- https://horticulture.oregonstate.edu/oregon-vegetables/onions-dry-bulb-western-oregon

### Sunflower

- https://homeguides.sfgate.com/types-environments-sunflowers-grow-in-69352.html
- https://www.almanac.com/plant/sunflowers
- http://www.canadasunflower.com/wp-content/uploads/2012/11/Fertility.pdf
- http://www.ikisan.com/ap-sunflower-soils-climate.html
- https://www.thehealingcanna.com/growroom-temperature-humidity

### Canola

- https://hort.purdue.edu/newcrop/afcm/canola.html
- https://www.farmersweekly.co.za/farm-basics/how-to-crop/growing-canola/
- https://webapp.agron.ksu.edu/agr_social/m_eu_article.throck?article_id=1507
- https://www.canolawatch.org/2012/02/09/how-much-fertilizer-does-canola-need/
- http://agriculture.vic.gov.au/agriculture/grains-and-other-crops/crop-production/growing-canola
- http://canola.okstate.edu/cropproduction/storagetransport

### Flax

- https://www.richters.com/show.cgi?page=InfoSheets/d2701.html
- https://www.britannica.com/plant/flax
- https://www.americanmeadows.com/wildflower-seeds/wildflower-species/how-to-grow-flax
- https://link.springer.com/article/10.1186/s12870-019-1641-1
- https://www.producer.com/2016/01/flax-responds-to-inputs-like-other-crops/
- http://corn.agronomy.wisc.edu/Crops/Flax.aspx
- https://www.researchgate.net/figure/Ambient-temperature-rainfall-and-relative-humidity-during-flaxseed-growing-season-of_fig1_266588977

### Sugarcane

- http://www.yourarticlelibrary.com/cultivation/geographical-conditions-required-for-the-growth-of-sugarcane/25533
- http://www.sugarcanecrops.com/climate/
- https://www.smart-fertilizer.com/articles/guide-to-growing-sugarcane
- http://www.sugarcanecrops.com/soil_requirement/
- https://www.gardeningknowhow.com/edible/herbs/sugarcane/feeding-sugarcane-plants.htm
- http://agropedia.iitk.ac.in/content/tropical-climate-sugarcane

### Sugarbeets

- https://hort.purdue.edu/newcrop/afcm/sugarbeet.html
- https://extension.colostate.edu/topic-areas/agriculture/fertilizing-sugar-beets-0-542/

### Almond

- https://homeguides.sfgate.com/almond-tree-growth-63440.html
- https://www.gardeningknowhow.com/edible/nut-trees/almonds/growing-almond-nut-trees.htm
- https://homeguides.sfgate.com/care-almond-trees-45296.html
- http://fruitsandnuts.ucdavis.edu/almondpages/AlmondNutrientsFertilization/
- https://gardenerspath.com/plants/nut-trees/growing-almonds/
- http://www.almonds.com/sites/default/files/content/attachments/alm-0601_stockpilingguide_grower_c6.pdf
 
### Pecan

- https://homeguides.sfgate.com/temperature-zone-pecan-trees-69135.html
- https://www.starkbros.com/products/nut-trees/pecan-trees
- https://content.ces.ncsu.edu/growing-pecans-in-north-carolina
- https://homeguides.sfgate.com/lime-application-rates-pecan-trees-53868.html
- https://www.uaex.edu/publications/PDF/FSA-6131.pdf
- https://www.growveg.com/plants/us-and-canada/how-to-grow-pecans/
- https://www.farmersweekly.co.za/farm-basics/how-to-crop/advice-growing-pecan-nuts/

### Walnut

- https://www.gardeningknowhow.com/edible/nut-trees/walnut/planting-walnut-trees.htm
- https://permaculturenews.org/2016/11/23/essential-guide-everything-need-know-growing-walnuts-juglans-regia/
- https://www.ncrs.fs.fed.us/pubs/wn/wn_2_01.pdf
- https://homeguides.sfgate.com/good-dirt-walnut-trees-45251.html
- http://www.fertilizerforless.com/2017/05/02/growing-walnuts-organically/
- https://wikifarmer.com/walnut-tree-climate-requirements/
- https://www.frutas-hortalizas.com/Fruits/Postharvest-Walnut.html

### Carrot

- https://homeguides.sfgate.com/soil-climate-requirement-carrot-production-37802.html
- https://www.gardeningknowhow.com/edible/vegetables/carrot/healthy-carrot-soil.htm
- https://homeguides.sfgate.com/low-ph-soil-affecting-carrot-plant-68706.html
- https://www.backyard-vegetable-gardening.com/watering-carrots.html
- https://www.almanac.com/plant/carrots
- https://gardening.usask.ca/articles-growing-information/carrots.php

### Bell Peppers

- https://harvesttotable.com/how_to_grow_sweet_peppers/
- https://gardenerspath.com/plants/vegetables/growing-using-bell-peppers/
- https://www.goodhousekeeping.com/home/gardening/a20705612/growing-peppers/
- https://homeguides.sfgate.com/soil-use-california-wonder-bell-pepper-53385.html
- https://homeguides.sfgate.com/nutrient-requirements-pepper-plants-64028.html
- https://www.almanac.com/plant/bell-peppers
- http://agriculture.infoagro.com/crops/how-to-grow-peppers/
