import matplotlib.pyplot as plt
import numpy as np
import matplotlib
import random
from mpl_toolkits.mplot3d import Axes3D
import math as ma

########### Edit Here the functions ##############

Dataset = 2   #which dataset to use

Hiddendime = 5 #Number of layers

inpudime = 2 #Number of input dimensions

loops = 10000  #Number of iterations

check = 1   #Iterations for plots

lamda = 0.01  # lamda has to be between 0 to 1

func = 1  # 1 for tanh 2 for sigmoid 3 for relu

prepro = 1 # 1 for preprocessing

reg = 1 # 1 for regularization  
beta = 0.001 #for regularization

soft = 1 #1 for softmax

drop = 1 #1 enable dropout

gradi = 1 #1 to enable stochastic gradient descent algorithm
gper = 0.1 #percentage to be taken in stochastic gradient descent algorithm (0.5 is 50%)

## While entering the dimensions in command promt make sure the last layer is equal to 2 ##

############################################

####### Definations ############

def sig(x):
	
	signal = 1.000/(1 + np.exp(-x))
	x2 = np.nan_to_num(signal)
	return x2
#define differntiation of sigmoid function
def sigdi(x):
	signn = x*(1-x)
	x3 = np.nan_to_num(signn)
	return x3

def tandif(x):
	return 1 - (np.tanh(x)*np.tanh(x))

def tanhh(x):
	return np.tanh(x)

def relu(x):
	r = np.maximum(0,x)
	#print(r)
	return r

def drelu(x):
	r = np.maximum(0,x)
	r[r > 0]=1
	return r


def forw(model):
	moods = {}
	#print('pass')
	X, W1, b1, ff = model['X'], model['W1'], model['b1'], model['ff']
	z1 = np.dot(X, W1) + b1
	if (ff == 1 ):
		a1 = np.tanh(z1)
	elif (ff ==2):
		a1 = sig(z1)
	else:
		a1 = relu(z1)
	#print(a1.shape)
	return (a1, z1)


def backs(d, ff):
	if(ff == 1):
		d1 = tandif(d)
	elif(ff==2):
		d1 = sigdi(d)
	else:
		d1 = drelu(d)
	return(d1)

def softmax(x):
    ty = len(x)
    ret = ['0']*ty
    sf = np.exp(x)
    dv = np.sum(sf, axis=1, keepdims= True)
    #print(dv)
    for y in range(0, ty):
    	ret[y] = sf[y]/dv[y]
    #print (ret)
    return ret

def crossen(x, y):
	lo = np.exp(x)
	lw = np.sum(lo, axis=1, keepdims=True)
	#print(lw)
	xp = lo/lw
	Gt = y*np.log(xp)
	#print(Gt)
	Hj = np.sum(Gt, axis=1, keepdims=True)
	Rj = np.sum(Hj, axis=0)
	#print(Rj)
	return Hj

def crosbaack(x,y):
	de = np.exp(x)
	lw = np.sum(de, axis=1, keepdims=True)
	#print(lw)
	xp = de/lw
	sh = xp - y
	return sh
###########################

### Main code starts######

if (Dataset == 1):
	X = np.loadtxt("hw2_data1.txt")
elif (Dataset == 2):
	X = np.loadtxt("hw2_data2.txt",delimiter = ',')
else:
	X = np.loadtxt("hw2_data4.txt")

np.random.shuffle(X)
hh = inpudime

#print(X)
if(prepro == 1):
	K = X.mean(axis=0)
	Min = np.array([K[0], K[1], 0])
	X = (X - Min) 
	X = X / X.max(axis=0)
	#print(Min)
	#print(X)



lenn = round(len(X)*0.9)
Xd = X[:lenn]
Xl = X[lenn:]
#print(Xd.shape)


#print(hh)
Ot = inpudime
Xout = Xl[:,:hh]
Oout = Xl[:,Ot]

if (gradi == 0):
	Xin = Xd[:,:hh]
	O = Xd[:,Ot]
	tt = len(Xin)
	O111p = ['0']*tt
	for i in range(0, tt):
		if (O.item((i)) == 1):
			O111p[i] = [0,1]
		else:
			O111p[i] = [1,0]




W = ['0'] * Hiddendime
NumNe = ['0']*Hiddendime
b = ['0']*Hiddendime
dW = ['0'] * Hiddendime
db = ['0'] * Hiddendime
Sx = ['0'] * Hiddendime
ZZ = ['0'] * Hiddendime
we = ['0'] * Hiddendime
L = ['0'] * int(loops/check)
lll = ['0'] * int(loops/check)



tw = len(Xout)
O222p = ['0']*tw
for i in range(0, tw):
	if (Oout.item((i)) == 1):
		O222p[i] = [0,1]
	else:
		O222p[i] = [1,0]



for i in range(0, Hiddendime):
	NumNe[i] = int(input('Enter number of Neurons for:  '))
	if(i == 0):
		W[i] = np.random.randn(inpudime, NumNe[i])
		dropoo = np.ones((NumNe[i]))
		#print(dropoo)
	else:
		W[i] = np.random.randn(NumNe[i-1], NumNe[i])
	print('Shape of W', i , W[i].shape)
	b[i] = np.zeros((1, NumNe[i]))
	print('Shape of b', i , b[i].shape)
	
	#print(W[i])
#print(Xin.shape)
model = {}
moods = {}
dr = 0
for j in range(0, loops):
	if (gradi == 1):
		np.random.shuffle(Xd)
		ter = round((len(Xd))*gper)
		Xc = Xd[:ter]
		Xin = Xc[:,:hh]
		#if(j==0):
		#	print(Xin)
		O = Xc[:,Ot]
		tt = len(Xin)
		O111p = ['0']*ter
		for i in range(0, ter):
			if (O.item((i)) == 1):
				O111p[i] = [0,1]
			else:
				O111p[i] = [1,0]
	#print("loop", j)
		#print(dropoo)
		#print(W[0])

	dW = ['0'] * Hiddendime
	db = ['0'] * Hiddendime
	Sx = ['0'] * Hiddendime
	ZZ = ['0'] * Hiddendime
	we = ['0'] * Hiddendime
	a1 = 0
	z1 = 0
	#print(Xin.shape)
	model = { 'X': Xin, 'W1': W[0], 'b1': b[0], 'ff' : func}
	a1, z1 = forw(model)
	if(drop == 1):
		dropoo[dr] = 0
		if (dr ==0):
			dropoo[NumNe[0]-1] = 1
		else:
			dropoo[dr-1] = 1
		dr += 1
		if (dr >= NumNe[0]):
			dr = 0
		Y = a1*dropoo
	else:
		Y = a1
	#print(Y)
	ZZ[0] = z1
	Sx[0] = Y
	for k in range (1, Hiddendime):
		#print('he')
		model = { 'X': Y, 'W1': W[k], 'b1': b[k], 'ff' : func}
		a1, z1 = forw(model)
		#print(k, a1.shape, z1.shape)
		Y = a1
		Sx[k] = Y
		ZZ[k] = z1
	qww = backs(z1, func)
	#print(len(Y), len(O111p))
	if (soft == 1):
		xxz = crosbaack(Y, O111p)
	else:
		xxz = (Y - O111p)
	we[Hiddendime-1] = xxz*qww
	db[Hiddendime-1] = np.sum(we[Hiddendime-1], axis=0, keepdims=True) / tt
	dW[Hiddendime-1] = np.dot(Sx[Hiddendime-2].T, we[Hiddendime-1])
	if(soft != 1):
		temp = np.sum((Y-O111p), axis =1, keepdims=True)/2
	else:
		temp = crossen(Y, O111p)
	G = np.sum(temp)/tt
	#print(Y)
	#print(abs(G))
	if(j%check == 0):
		kk2 = int(j/check)

		lll[kk2] = kk2
		L[kk2] = abs(G)
		#print(L[kk2]) 


	#print(db[Hiddendime-1])	

	for g in range(1, Hiddendime-1):
		kk = (Hiddendime -1) - g
		qww = 0
		qww = backs(ZZ[kk], func)
		#print(qww.shape)
		we[kk] = np.dot(we[kk+1], np.transpose(W[kk+1])) * qww
		dW[kk] = np.dot(Sx[kk-1].T, we[kk])
		#print(we[kk].shape)
		#print(kk, dW[kk].shape)
		db[kk] = np.sum(we[kk], axis=0, keepdims=True) / tt
		#print('db', db[kk])

	qww = backs(ZZ[0], func)
	#print(qww.shape)
	we[0] = np.dot(we[1], np.transpose(W[1])) * qww
	dW[0] = np.dot(Xin.T, we[0])
	#print(we[0].shape)
	db[0] = np.sum(we[0], axis=0, keepdims=True) / tt

	for s in range(0, Hiddendime):
		if(reg == 1):
			Df = W[s]
			N = len(Df[1,:]) + len(Df[:,1])
			W[s] = (1 - 2*beta/N)*W[s] - lamda*dW[s]/tt
			Gn = len(b[s])
			b[s] = (1 - 2*beta/Gn)*b[s] - lamda*db[s]
				
		else:	
			W[s] += -lamda*dW[s]/tt
			b[s] += -lamda*db[s]
			#print(dW[s]/tt)
					

a1 = 0
z1 = 0
#print('w',W[0],'b', b[0])
model = { 'X': Xout, 'W1': W[0], 'b1': b[0], 'ff' : func}
a1, z1 = forw(model)
for k in range (1, Hiddendime):
	#print('he')
	model = { 'X': a1, 'W1': W[k], 'b1': b[k], 'ff' : func}
	a1, z1 = forw(model)

#print(a1)

if (soft == 0):
	rtt = ((a1-O222p)*(a1-O222p))/2
	temp = np.sum(rtt, axis =1, keepdims=True)/2
	G = np.sum(temp)/tw
	print('Loss', abs(G))
else:
	chh = len(a1)
	err = 0
	aa = [softmax(a1)]
	ac = np.asarray(aa)
	ab = ac[0]
	for e in range(0, chh):
		wq = ab[e]
		ooo = O222p[e]
		#print(wq, ooo)
		if(abs(wq[0] - ooo[0]) > 0.5):
			err += 1
	print('Error', err/chh)

plt.figure()
plt.plot(lll, L )
plt.title('Loss Plot', fontsize=20)
plt.xlabel('Iterations x %i '%(check),   fontsize=14)
plt.ylabel('Loss', fontsize=14)
plt.show()


