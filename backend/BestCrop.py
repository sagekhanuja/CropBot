# -*- coding: utf-8 -*-
"""
Created on Fri Dec 27 20:30:33 2019

@author: Rinav R Kasthuri

This is the Best Crop prediction model for CropBot.

The model defined below accepts a 6 x 1 input vector that represents the
temperature in Fahrenheit, climate, soil, soil pH, precipitation (mm / month), and humidity

The model then predicts the aforementioned conditions to be suitable for
one out of N possible crops.

To actually train the model, you will need to download "Best Crop Data.xlsx"
and store it in the same directory as this file.
"""


import pandas as pd
import numpy as np
from tensorflow.keras import Sequential
from tensorflow.keras.layers import Dense, Activation, Flatten
from tensorflow.keras.models import load_model
from tensorflow.keras.optimizers import Adam

# file to extract data from
DATA_FILE = "Best Crop Data v2.xlsx"

# name to save the model with
MODEL_NAME = "BestCrop.h5"


class BestCrop:
    
    
    # post: initializes the relevant variables by extracting data
    #       from the given file
    def __init__(self, file):
        dataAndPred = pd.read_excel(file)
        
        data = []
        pred = []
        
        keys = dataAndPred.keys()
        
        self.cropList = sorted(set(dataAndPred[keys[0]]))
        
        for i in range(len(dataAndPred)):
            features = []
            cropKey = dataAndPred[keys[0]][i]
            
            # extracts the values in all of the categories for the given row
            # except the actual crop name
            for feature in keys[1:]:
                features.append(dataAndPred[feature][i])
            
            # extracts the matching prediction value (i.e., the crop name)
            for i in range(len(self.cropList)):
                if cropKey == self.cropList[i]:
                    pred.append(self.getOneHot(i, len(self.cropList)))
            
            data.append(features)
        
        self.data = np.expand_dims(data, -1)
        self.pred = np.array(pred)
        
    
    # post: creates a model from the one given if a model is inputted,
    #       else creates a model with the architecture below
    def createModel(self, model = None):
        lr = 1e-5
        
        optimizer = Adam(lr)
        
        if model == None:
            model = Sequential()
            model.add(Dense(128, input_shape = (len(self.data[0]), 1),
                            activation = 'tanh'))
            model.add(Dense(256, activation = 'tanh'))
            model.add(Dense(512, activation = 'tanh'))
            model.add(Dense(1024, activation = 'tanh'))
            
            model.add(Flatten())
            
            model.add(Dense(len(self.cropList)))
            model.add(Activation("softmax"))
        else:
            model = load_model(model)
        
        model.compile(loss = 'categorical_crossentropy', metrics = ['accuracy'], optimizer = optimizer)
        print(model.summary())
        
        return model
    
    
    # pre: accepts model to train,
    #              desired name of model when finished training,
    #              number of epochs to train model for,
    #              number of samples to train with on each epoch,
    #              number of iterations to run through (different from epochs)
    
    # post: trains given model and saves it with the given model name
    def train(self, model, modelName, numEpochs = 100, batchSize = 4, numIterations = 1):
        # saves model every iteration (i.e., after each set of numEpochs)
        for i in range(numIterations):
            model.fit(self.data, self.pred, epochs = numEpochs, shuffle = True, batch_size = batchSize)
            
            model.save(modelName)
    
    
    # pre: accepts model to predict with,
    #      data to test model with
            
    # post: prints out the model's prediction from the given data
    def predict(self, model, data):
        print(self.cropList[np.argmax(model.predict(data))])
        
    
    # pre: required index and number of classes
        
    # post: returns one-hot representation of given index within
    #       given number of classes
    def getOneHot(self, index, numClasses):
            oneHotVector = np.zeros(numClasses)
            oneHotVector[index] = 1
            
            return oneHotVector
        
        
if __name__ == '__main__':
    bc = BestCrop(DATA_FILE)
    
    model = bc.createModel("BestCrop.h5")
    
    bc.train(model, MODEL_NAME, numEpochs = 10)