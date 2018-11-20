# -*- coding: utf-8 -*-
"""
Created on Sun Nov 18 17:10:17 2018

@author: Tianxin
"""

import os
import sys
import numpy as np
import matplotlib.pyplot as plt

def GetAccelerationArr(array,interval):
    deriv = np.zeros(len(array))
    deriv[0] = None
    deriv[1] = None
    deriv[2] = None
    deriv[3] = None
    for i in range(4,len(array)-1):
        deriv[i] = (-25*array[i] + 48*array[i-1] - 36*array[i-2]+16*array[i-3]-3*array[i-4])/(-12*interval)
    return deriv

def ShowModelPerformance(x_test,y_test,x_train,y_train,model,name):
    print("Training error of ",name," classifier is:",np.mean(model.predict(x_train)==y_train))
    print("Test error of Naive Bayes ",name," is:",np.mean(model.predict(x_test)==y_test))
    print('The predicted labels are:\n',model.predict(x_test))
    print('The actual labels are:\n',y_test)
    t = np.arange(0,(len(y_test))*0.1,0.1)
    plt.figure(figsize=(10,10))
    fig = plt.plot(t,model.predict(x_test),'r*',label = 'Predicted Label')
    plt.plot(t,y_test,'bo',label = 'Actual Label')
    plt.legend(loc='upper left')
    plt.show()