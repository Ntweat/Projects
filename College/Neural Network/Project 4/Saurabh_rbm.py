
#Importing Libraries
import numpy as np

# Importing libraries from sklearn
from sklearn import datasets, cross_validation
from sknn.mlp import Classifier, Layer, Convolution
from sklearn.pipeline import Pipeline
from sklearn.neural_network import BernoulliRBM
from sklearn.datasets import fetch_mldata
from sklearn.cross_validation import train_test_split

mnist = fetch_mldata('mnist-original')
TrainImage, TrainLabel, TestImage, TestLabel = train_test_split((mnist.data / 255.0).astype(np.float32),mnist.target.astype(np.int32),test_size=0.25) 
BRBM = BernoulliRBM(n_components= 400, n_iter= 15 , verbose=True)
ll = Classifier(layers=[Convolution('Tanh', channels=5, kernel_shape=(4, 4), border_mode='full'),Layer('Tanh', units=100),Layer('Softmax')],learning_rate=0.05,valid_size=0.15, verbose=True)

make = Pipeline(steps=[('BRBM', BRBM), ('ll', ll)]) 

make.fit(TrainImage, TestImage) 

print('\n Accuracy in training', make.score(TrainImage, TestImage))
print('Accuracy in testing', make.score(TrainLabel, TestLabel))  
