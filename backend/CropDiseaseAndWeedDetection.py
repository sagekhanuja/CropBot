# -*- coding: utf-8 -*-
"""
Created on Fri Dec 20 10:42:32 2019

@author: Rinav R Kasthuri

This is the Crop Disease and Weed Detection module for CropBot.

The model defined below accepts a 256 x 256 x 3 image and classifies it
as one of either 38 diseased crops or 2 weed-types.

This model produced a 98% accuracy with the "New Plant Diseases Dataset"
which can be found here: https://www.kaggle.com/vipoooool/new-plant-diseases-dataset

To actually train this model, you will have to first download the above dataset
and then change the "trainDir" and "validDir" to the appropriate training directory
and validation directory.
"""

from tensorflow.keras.layers import Dense, Conv2D, Flatten, Activation, MaxPooling2D
from tensorflow.keras.optimizers import Adagrad
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from tensorflow.keras.models import load_model
from tensorflow.keras import Sequential

SHAPE = (256, 256, 3)
NUM_CROPS = 38

class CropDiseaseAndWeedDetection:
    # post: initializes the prospective model's name, the directory to extract training data
    #       from, and the directory to extract validation data from
    def __init__(self, modelName, tDir, vDir):
        self.modelName = modelName
        self.trainDir = tDir
        self.validDir = vDir
    
    
    # post: produces the required model if model is None, else loads the given model
    def createModel(self, model = None):
        lr = 0.0008
        optim = Adagrad(lr)
        kernel = 'he_normal'
        
        # activation used in all of the convolutional layers
        convActivation = 'tanh'
        
        if (model == None):
            model = Sequential([
                Conv2D(32, (8, 8), input_shape = SHAPE, strides = (2, 2),
                     kernel_initializer=kernel, activation = convActivation),
                Conv2D(64, (16, 16),
                             kernel_initializer=kernel,
                             activation = convActivation),
                MaxPooling2D((8, 8)),
                Conv2D(128, (8, 8),
                             kernel_initializer=kernel,
                             activation = convActivation),
                Conv2D(256, (4, 4),
                             kernel_initializer=kernel,
                             activation = convActivation),
                Conv2D(512, (2, 2),
                             kernel_initializer=kernel,
                             activation = convActivation),
                Dense(4096, activation = convActivation),
                Dense(4096, activation = convActivation),
                Flatten(),
                Dense(NUM_CROPS),
                Activation("softmax")])
        else:
            model = load_model(model)
        
        # compiles and prints out the model's structure
        model.compile(loss = 'binary_crossentropy', metrics = ['accuracy'], optimizer = optim)
        print(model.summary())

        return model
    
    
    # pre: accepts model (which must throws ValueError otherwise),
    #      number of epochs to train the model for,
    #      number of steps to train on each epoch,
    #      number of samples to train on each step
    #      number of iterations to run each set of epochs,
    #      a flag for whether model evaluation is desired
    
    # post: trains the model according to the given hyperparameters
    def trainModel(self, model, numEpochs = 10, numSteps = 1000, batchSize = 16, numIterations = 1, canEvaluate = False):
        # augmentations to apply to the images when feeding into the model
        # this both helps the model learn across a broader range of data
        # and also helps prevent overfitting
        genData = {
                   'width_shift_range':0.2,
                   'horizontal_flip':True,
                   'vertical_flip':True,
                   'height_shift_range':0.2,
                   'shear_range':0.25,
                   'zoom_range':0.2,
                   'rotation_range':20
                  }
                
        generator = ImageDataGenerator(**genData)
        
        trainFlow = generator.flow_from_directory(self.trainDir, batch_size = batchSize)
        
        # allows the model to periodically save
        for i in range(numIterations):
            model.fit_generator(trainFlow, steps_per_epoch = numSteps, epochs = numEpochs)
        
            model.save(self.modelName)
        
        if canEvaluate:    
            validFlow = generator.flow_from_directory(self.validDir, batch_size = batchSize)
            
            print(model.evaluate(validFlow))
            
if __name__ == "__main__":
    modelName = "CropDiseaseDetection.h5"
    
    # store this file in the same folder as the "New Plant Diseases Dataset" folder that
    # contains the directory below
    trainDir = r"New Plant Diseases Dataset(Augmented)\train"
    validDir = r"New Plant Diseases Dataset(Augmented)\valid"
    
    cropBot = CropDiseaseAndWeedDetection(modelName, trainDir, validDir)
    
    model = cropBot.createModel(modelName)
    
    cropBot.trainModel(model)
