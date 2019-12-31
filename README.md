# CropBot: Empowering Low-Income Farmers with AI 
# *By Nikolas Ioannou, Rinav Kasthuri, and Sage Khanuja*

## Overview
CropBot is a mobile application that allows farmers across the globe to more smartly utilize their fields. This smarter utilization is facilitated through our voice assistant, Tea, who asks the farmer relevant questions about the state of his or her field to gauge prospective betterments and then implement them.

## Inspiration
Most of our team comes from India. We’d witnessed the robbing of numerous farmers’ livelihoods due to preying middlemen, landlords, or simply a lack of relevant knowledge. We were surprised to find that there were no existing apps that focused on increasing accessibility of this knowledge for impoverished farmers. Thus, it became clear to us that there’d be a prominent utility for an app that could combat crop diseases, predict shock events such as droughts or floods, and provide useful information like the best crop to grow based on the land’s geographical features. Moreover, this presented our team with an opportunity and a challenge—to utilize our machine learning and app development skill sets to better the lives of millions.

## Functional Framework
To explain our app's functioning on a technical level, we will use an example of a farmer who thinks his crops have some fungus. The farmer first explains his problem to CropBot, who then interprets the message using NLP. In this particular case, CropBot will assess the farmer's message as a "Crop Disease intent" message. CropBot will then ask the farmer to take a picture of the crop using the app. CropBot will then resize the image and feed it to the app's relevant Keras model. The model will output a softmax vector which will then be appropriately categorized and returned to the API, which finally displays the relevant disease and gives suggestions for what the farmer could do next.
## Methods
The app currently features crop disease and weed detection and best crop, crop price, and drought prediction.

This section will be split into three subsections to delineate the three distinct TF 2.0 models used to produce the aforementioned features:

  1. Crop Disease and Weed Detection
  2. Best Crop and Crop Price Prediction
  3. Drought Prediction
  
### 1. Crop Disease and Weed Detection
![Model Structure - CDWD](https://github.com/sagek21/AGH/blob/master/CropDiseaseDetection.png)

(A novel CNN architecture designed specifically for this app)

The N-long softmax vector (where N is the number of classifiable crop diseases or weeds) of the model are sent to a Google API which then appropriately categorizes the outputs into the relevant disease and displays it.

### 2. Best Crop and Crop Price Prediction
![Model Structure - BCP](https://github.com/sagek21/AGH/blob/master/BestCrop.png)

(A DNN for the Best Crop predictor and a LSTM-based net for the Crop Price predictor)

For the Best Crop Predictor, an N-long softmax vector (where N is the number of classifiable crops) is utilized by the aforementioned Google API to produce the relevant output. In the case of the Crop Price predictor, a LSTM-based network predicts the price of a crop on the next day based on the previous three days' prices.

## Impact
Our primary goal with CropBot is to help the impoverished and illiterate farmers who are being left to starve when droughts, storms, and floods, ravenous landlords or relatively richer farmers simply discard their livelihoods. Using CropBot, these farmers can significantly improve their situations by not only learning more on the field, but also by learning more about the field itself. Additionally, we have implemented our application through both text and voice to accommodate the desponding illiteracy that still unfortunately prevails in today’s world. In its ideal form, the app could potentially reduce the disparity between the yields of rich and poor farmers from 214% to a miniscule 5% (Restuccia et al., 2017).
