import matplotlib.pyplot as plt
import numpy as np
import matplotlib
import random
from mpl_toolkits.mplot3d import Axes3D




#### Edit Here the functions ##############

Dataset = 3


Opt = 1 #Opt = 1, use 90% for training Opt = 0, use full dataset for training

loops = 5000

check = 10

lamda = 0.1  # lamda has to be between 0 to 1


############################################

if (Dataset == 1):
	X = np.loadtxt("hw2_data1.txt")
elif (Dataset == 2):
	X = np.loadtxt("hw2_data2.txt",delimiter = ',')
else:
	X = np.loadtxt("hw2_data4.txt")

np.random.shuffle(X)

xx1 = X[:,0]
xx2 = X[:,1]
if (Dataset == 3):
	xx3 = X[:,2]
	O = X[:,3]
	fig = plt.figure()
	ax = plt.axes(projection='3d')
	ax.scatter(xx1, xx2, xx3, zdir='x3', s=len(xx1), c=O, cmap=plt.cm.Spectral, depthshade=True)
else:
	O = X[:,2]
	plt.scatter(xx1, xx2, c=O, cmap=plt.cm.Spectral, alpha = 0.75)
	plt.title('Intial Data Set', fontsize=20)
	plt.xlabel('x1', fontsize=14)
	plt.ylabel('x2', fontsize=14)


if (Dataset == 1):
	xx1 = xx1 / xx1.mean()
	xx2 = xx2 / xx2.mean()

def sig(x):
	return 1.000/(1 + np.exp(-x))

#define differntiation of sigmoid function
def dif(x):
	return x*(1-x)



O111p = []
O222p = []

#print(len(xx3))

tt = len(xx1)


for i in range(0, tt):
	if (O.item((i)) == 1):
		O111p.append(0)
		O222p.append(1)
		
	else:
		O111p.append(1)
		O222p.append(0)
		

if (Opt == 1):
	lenn = round(len(xx1)*0.9)
	print(lenn)
	x1 = xx1[:lenn]
	fin = O[lenn:]
	x1o = xx1[lenn:]
	x2 = xx2[:lenn]
	x2o = xx2[lenn:]
	if(Dataset == 3):
		x3o = xx3[lenn:]
		#print(x3)
		x3 = xx3[:lenn]

	O11p = O111p[:lenn]
	O1p = O111p[lenn:]
	O22p = O222p[:lenn]
	O2p = O222p[lenn:]

	if(Dataset != 3):
		plt.figure()
		plt.scatter(x1o, x2o, c=fin, cmap=plt.cm.Spectral, alpha = 0.75)
		plt.title('Test Data Set', fontsize=20)
		plt.xlabel('x1', fontsize=14)
		plt.ylabel('x2', fontsize=14)
	else:
		fig2 = plt.figure()
		ax = plt.axes(projection='3d')
		ax.scatter(x1o, x2o, x3o, zdir='x3', s=len(x1), c=fin, cmap=plt.cm.Spectral, depthshade=True)
	

	
	
else:
	x1 = xx1
	x1o = xx1
	x2 = xx2
	x2o = xx2
	if(Dataset == 3):
		x3o = xx3
		x3 = xx3
	O11p = O111p
	O1p = O111p
	O22p = O222p
	O2p = O222p



t = len(x1)
print(t)

W1 = 0.9
b11 = 0
W2 = 0.9
b21 = 0
b12 = 0
b22 = 0
W3 = 0.5
W4 = 0.6
W5 = 0.7
W6 = 0.8
W7 = 0.7
W8 = 0.9
if(Dataset == 3):
	W9 = 0.6
	W10 = 0.7

Z11 = ['0']*t
Z12 = ['0']*t
X11 = ['0']*t
X12 = ['0']*t
Z21 = ['0']*t
X21 = ['0']*t
X22 = ['0']*t
Z22 = ['0']*t
X31 = ['0']*t
X32 = ['0']*t
rrr = int(loops/10)
Lr = ['0']*rrr
lll = ['0']*rrr

for loo in range (0, loops):
	#print ('hi')
	G = 0
	DW1 = 0
	DW2 = 0
	DW3 = 0
	DW4 = 0
	DW5 = 0
	DW6 = 0
	DW7 = 0
	DW8 = 0
	DW9 = 0
	DW10 = 0
	Db11 = 0
	Db12 = 0
	Db21 = 0
	Db22 = 0

	#print(len(x3))
	#print(len(x2))

	for i in range (0, t):
		#print(i)
		#Forward propogation
		if(Dataset == 3):
			Z11[i] = x1[i]*W1 + x2[i]*W2 +x3[i]*W9 + b11
			Z12[i] = x1[i]*W3 + x2[i]*W4 +x3[i]*W10 + b12
		else:
			Z11[i] = x1[i]*W1 + x2[i]*W2 + b11
			Z12[i] = x1[i]*W3 + x2[i]*W4 + b12

		#print(W1)
		X11[i] = sig(Z11[i])
		X12[i] = sig(Z12[i])

		Z21[i] = X11[i]*W5 + X12[i]*W6 + b21
		Z22[i] = X11[i]*W7 + X12[i]*W8 + b22

		X21[i] = sig(Z21[i])
		X22[i] = sig(Z22[i])

		L = ((X21[i] - O11p[i])*(X21[i] - O11p[i])) + ((X22[i] - O22p[i])*(X22[i] - O22p[i]))

		#Backward propogation
		#define initial elements

		dLX21 = (X21[i] - O11p[i])
		dLX22 = (X22[i] - O22p[i])

		dX21Z21 = dif(X21[i])
		dX22Z22 = dif(X22[i])

		dZ21X11 = W5
		dZ21X12 = W6
		dZ22X11 = W7
		dZ22X12 = W8

		dX11Z11 = dif(X11[i])
		dX12Z12 = dif(X12[i])

		dZ11x1 = W1
		dZ11x2 = W2
		dZ12x1 = W3
		dZ12x2 = W4

		dZ21W5 = X11[i]
		dZ21W6 = X12[i]
		dZ22W7 = X11[i]
		dZ22W8 = X12[i]

		dZ11W1 = x1[i]
		dZ11W2 = x2[i]
		dZ12W3 = x1[i]
		dZ12W4 = x2[i]
		if(Dataset ==3):
			dZ11W9 = x3[i]
			dZ12W10 = x3[i]

		#define elements needed

		dLW5 = dLX21*dX21Z21*dZ21W5
		dLW6 = dLX21*dX21Z21*dZ21W6
		dLW7 = dLX22*dX22Z22*dZ22W7
		dLW8 = dLX22*dX22Z22*dZ22W8
		dLb21 = dLX21*dX21Z21
		dLb22 = dLX22*dX22Z22

		dLW1 = (dLX21*dX21Z21*dZ21X11*dX11Z11*dZ11W1) + (dLX22*dX22Z22*dZ22X11*dX11Z11*dZ11W1)
		dLW2 = (dLX21*dX21Z21*dZ21X11*dX11Z11*dZ11W2) + (dLX22*dX22Z22*dZ22X11*dX11Z11*dZ11W2)
		dLb11 = (dLX21*dX21Z21*dZ21X11*dX11Z11) + (dLX22*dX22Z22*dZ22X11*dX11Z11)

		dLW3 = (dLX21*dX21Z21*dZ21X12*dX12Z12*dZ12W3) + (dLX22*dX22Z22*dZ22X12*dX12Z12*dZ12W3)
		dLW4 = (dLX21*dX21Z21*dZ21X12*dX12Z12*dZ12W4) + (dLX22*dX22Z22*dZ22X12*dX12Z12*dZ12W4)
		dLb12 = (dLX21*dX21Z21*dZ21X12*dX12Z12) + (dLX22*dX22Z22*dZ22X12*dX12Z12)
		if(Dataset == 3):
			dLW9 = (dLX21*dX21Z21*dZ21X11*dX11Z11*dZ11W1) + (dLX22*dX22Z22*dZ22X11*dX11Z11*dZ11W9)
			dLW10 = (dLX21*dX21Z21*dZ21X12*dX12Z12*dZ12W3) + (dLX22*dX22Z22*dZ22X12*dX12Z12*dZ12W10)

		G += L

		#Collect datase 
		DW1 += dLW1
		DW2 += dLW2
		DW3 += dLW3
		DW4 += dLW4
		DW5 += dLW5
		DW6 += dLW6
		DW7 += dLW7
		DW8 += dLW8
		if(Dataset ==3):
			DW9 += dLW9
			DW10 += dLW10
		Db11 += dLb11
		Db12 += dLb12
		Db21 += dLb21
		Db22 += dLb22
		if(Dataset !=3):
			W5 += -lamda*dLW5
			W6 += -lamda*dLW6
			W7 += -lamda*dLW7
			W8 += -lamda*dLW8
			W1 += -lamda*dLW1
			W2 += -lamda*dLW2
			W3 += -lamda*dLW3
			W4 += -lamda*dLW4
		

			b11 += -lamda*dLb11
			b12 += -lamda*dLb12
			b22 += -lamda*dLb22
			b21 += -lamda*dLb21
		


	if(Dataset == 3):
		W5 += -lamda*DW5/t
		W6 += -lamda*DW6/t
		W7 += -lamda*DW7/t
		W8 += -lamda*DW8/t
		W1 += -lamda*DW1/t
		W2 += -lamda*DW2/t
		W3 += -lamda*DW3/t
		W4 += -lamda*DW4/t
		W9 += -lamda*DW9/t
		W10 += -lamda*DW10/t

		b11 += -lamda*Db11/t
		b12 += -lamda*Db12/t
		b22 += -lamda*Db22/t
		b21 += -lamda*Db21/t
	
	
	if(loo%check == 0):
		kk = int(loo/10)
		#print (kk)
		lll[kk] = kk
		Lr[kk] = G / t
		#print(loo)



	

Err = 0

r = len(x1o)

ZZ11 = ['0']*r
ZZ12 = ['0']*r
XX11 = ['0']*r
XX12 = ['0']*r
ZZ21 = ['0']*r
XX21 = ['0']*r
XX22 = ['0']*r
ZZ22 = ['0']*r
clas = ['0']*r

for j in range (0, r):
	#Forward propogation
	if(Dataset == 3):
			ZZ11[j] = x1[j]*W1 + x2[j]*W2 +x3[j]*W9 + b11
			ZZ12[j] = x1[j]*W3 + x2[j]*W4 +x3[j]*W10 + b12
	else:
			ZZ11[j] = x1[j]*W1 + x2[j]*W2 + b11
			ZZ12[j] = x1[j]*W3 + x2[j]*W4 + b12

	#print(ZZ11[j])
	XX11[j] = sig(ZZ11[j])
	#print(XX11[j])
	XX12[j] = sig(ZZ12[j])
		
	ZZ21[j] = XX11[j]*W5 + XX12[j]*W6 + b21
	ZZ22[j] = XX11[j]*W7 + XX12[j]*W8 + b22

	XX21[j] = sig(ZZ21[j])
	XX22[j] = sig(ZZ22[j])

	g1 = np.exp(XX21[j])
	g2 = np.exp(XX22[j])
	tot = g1+g2

	prob1 = g1/tot
	prob2 = g2/tot

	L = ((XX21[j] - O1p[j])*(XX21[j] - O1p[j])) + ((XX22[j] - O2p[j])*(XX22[j] - O2p[j]))

	if (prob1 >0.5):
		if (O1p[j] == 0):
			Err += 1
		clas[j] = 0

	if (prob2 >0.5):
		if (O2p[j] == 0):
			Err += 1
		clas[j] = 1

	#print('Next')
	#print(O1p[j], O2p[j])
	#print(XX21[j], XX22[j])
	#print(prob1, prob2)

print('Error percentage' ,  (Err/r)*100)
#print(loops)
plt.figure()
plt.plot(lll, Lr )
plt.title('Loss Plot', fontsize=20)
plt.xlabel('Iterations x %i '%(check),   fontsize=14)
plt.ylabel('Loss', fontsize=14)
if(Dataset != 3):
	plt.figure()
	plt.scatter(x1o, x2o, c=clas, cmap=plt.cm.Spectral, alpha = 0.75)
	plt.title('Reult: Classified', fontsize=20)
	plt.xlabel('x1', fontsize=14)
	plt.ylabel('x2', fontsize=14)
else:

	fig3 = plt.figure()
	ax = plt.axes(projection='3d')
	ax.scatter(x1o, x2o, x3o, zdir='x3', s=len(x1), c=clas, cmap=plt.cm.Spectral, depthshade=True)
	plt.title('Reult: Classified', fontsize=20)
	plt.xlabel('x1', fontsize=14)
	plt.ylabel('x2', fontsize=14)
	#plt.zlabel('x3', fontsize=14)

plt.show()
