import numpy as np
import theano as TH 
import theano.tensor as T
import lasagne as L
import nolearn
import gzip
import matplotlib.pyplot as plt
import matplotlib

############### Edit Functions here#############

loops = 70            #Number of iterations (Epochs)
check = 1             #After how many iterations should Loss be calculated for plot
Batch_Size = 1000     #Batch Size for training and testing
Ques = 1             #Question Number 1 or 2

#################################################


######### Deifne Functions ######################

def image(filename): 
	with gzip.open(filename, 'rb') as f:
		data = np.frombuffer(f.read(), np.uint8, offset=16) 		
	return data.reshape(-1,1,28,28) / np.float32(256)

def label(filename):
	with gzip.open(filename, 'rb') as f:
		ll = np.frombuffer(f.read(), np.uint8, offset=8)
	return ll

def Make_cnn(input_var=None):
	make = L.layers.InputLayer(shape=(None, 1, 28, 28),input_var=input_var)
	make = L.layers.Conv2DLayer(make, num_filters=10, filter_size=(5, 5),stride=2,nonlinearity=L.nonlinearities.rectify,W=L.init.Normal(0.01),b=L.init.Constant(0.1))
	make = L.layers.MaxPool2DLayer(make, pool_size=(4, 4))
	make = L.layers.DenseLayer(L.layers.dropout(make, p=.5),num_units=100,nonlinearity=L.nonlinearities.rectify)
	make = L.layers.DenseLayer(L.layers.dropout(make, p=.5),num_units=10, nonlinearity=L.nonlinearities.softmax)
	return make

def Make_cnn_2(input_var=None):
	make = L.layers.InputLayer(shape=(None, 1, 28, 28),input_var=input_var)
	make = L.layers.Conv2DLayer(make, num_filters=10, filter_size=(5, 5),nonlinearity=L.nonlinearities.rectify,W=L.init.Normal(0.01),b=L.init.Constant(0.1))
	make = L.layers.MaxPool2DLayer(make, pool_size=(4, 4))
	make = L.layers.Conv2DLayer(make, num_filters=10, filter_size=(5, 5),nonlinearity=L.nonlinearities.rectify,W=L.init.Normal(0.01),b=L.init.Constant(0.1))
	make = L.layers.MaxPool2DLayer(make, pool_size=(2, 2))
	make = L.layers.DenseLayer(L.layers.dropout(make, p=.5),num_units=100,nonlinearity=L.nonlinearities.rectify)
	make = L.layers.DenseLayer(L.layers.dropout(make, p=.5),num_units=10, nonlinearity=L.nonlinearities.softmax)
	return make


def it(inpu, target, BS):
	assert len(inpu) == len(target)
	for i in range(0, len(inpu) - BS + 1, BS):
		H = slice(i, i + BS)
		yield inpu[H], target[H]


############### Main code starts here ######################


RL = ['0'] * (int(loops/check)+1)
lll = ['0'] * (int(loops/check)+1)
TError = 0
ACC = 0
Tbatch = 0

TrainImage = image('data/train-images-idx3-ubyte.gz')
TrainLabel = label('data/train-labels-idx1-ubyte.gz')
TestImage = image('data/t10k-images-idx3-ubyte.gz')
TestLabel = label('data/t10k-labels-idx1-ubyte.gz')

InpVar = T.tensor4('inputs')
TgVar = T.ivector('targets')

if (Ques == 2):
	CNN = Make_cnn_2(InpVar)
else:
	CNN = Make_cnn(InpVar)

pred = L.layers.get_output(CNN)
Lfunct = L.objectives.categorical_crossentropy(pred, TgVar)
Lfunct = Lfunct.mean()

PP = L.layers.get_all_params(CNN, trainable=True)

UPD = L.updates.nesterov_momentum(Lfunct, PP, learning_rate=0.01, momentum=0.9)

testpred = L.layers.get_output(CNN, deterministic=True)
TestLoss = L.objectives.categorical_crossentropy(testpred,TgVar)
TestLoss = TestLoss.mean()

TestAcc = T.mean(T.eq(T.argmax(testpred, axis=1), TgVar), dtype=TH.config.floatX)
TrainFun = TH.function([InpVar, TgVar], Lfunct, updates=UPD)
error = TH.function([InpVar, TgVar], [TestLoss, TestAcc])

for j in range(loops):
    print("Starting Epoch ", j)
    Err = 0
    NumBatch = 0
    
    for K in it(TrainImage, TrainLabel, Batch_Size):
    	inputs, targets = K
    	Err += TrainFun(inputs, targets)
    	NumBatch += 1

    if(j%check == 0):
    	print("Loss: {:.2f}".format(Err / NumBatch))
    	print("---------------------------- ")
    	kk2 = int(j/check)
    	lll[kk2] = kk2
    	RL[kk2] = Err / NumBatch


print("---------------------- ")
print("Testing on Test data ")
print("---------------------- ")
for K in it(TestImage, TestLabel, Batch_Size):
	inputs, targets = K
	erro, accu = error(inputs, targets)
	TError += erro
	ACC += accu
	Tbatch += 1

print("Loss {:.2f}".format(TError / Tbatch))
print("Accuracy  {:.2f} %".format(ACC / Tbatch * 100))

SaveP = L.layers.get_all_param_values(CNN)
L.layers.set_all_param_values(CNN, SaveP)
print(SaveP[0])
	
plt.figure()
plt.plot(lll, RL )
plt.title('Training Loss Plot', fontsize=20)
plt.xlabel('Epoch x %i '%(check),   fontsize=14)
plt.ylabel('Loss', fontsize=14)
#plt.show()


