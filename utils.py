# -*- coding: utf-8 -*-
"""
Created on Sun Nov 18 17:10:17 2018

@author: Tianxin
"""

import os
import sys
import numpy as np

def GetAccelerationArr(array,interval):
    deriv = np.zeros(len(array))
    deriv[0] = None
    deriv[1] = None
    deriv[len(array) - 1] = None
    deriv[len(array) - 2] = None
    for i in range(2,len(array)-3):
        deriv[i] = (-array[i+2] + 8*array[i+1] - 8*array[i-1]+array[i-2])/(12*interval)
    return deriv