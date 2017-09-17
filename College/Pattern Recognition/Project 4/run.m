clearvars;
dforprojm = pwd;
prompt = 'Enter the file name of the dataset ';
str = input(prompt,'s');
data = load([str]);
prompt = 'Enter the file name for output ';
str1 = input(prompt,'s');
d = 0;
drt = 0;
arr = [data];
for ik = 1:10;
for k = 1:10;
drt =  25 + drt; 
d = drt;
if ik==1; 
ext = ['a' num2str(k) ];
end;
if ik==2; 
ext = ['c' num2str(k)];
end;
if ik==3; 
ext = ['e' num2str(k)];
end;
if ik==4;
ext = ['m' num2str(k)];
end;
if ik==5;
ext = ['n' num2str(k)];
end;
if ik==6;
ext = ['o' num2str(k)];
end;
if ik==7;
ext = ['r' num2str(k)];
end;
if ik==8;
ext = ['s' num2str(k)];
end;
if ik==9; 
ext = ['x' num2str(k)];
end;
if ik==10;
ext = ['z' num2str(k)];
end;
for j = 1:25;
a(j,:) = arr(d,:);
d=d-1;
end;
h.(ext) = a;

A(ik,k) = 0;
B(ik,k) = 0;
D(ik,k) = 0;
array = h.(ext);
        for i = 1:25;
             for j = 1:35 ;
 t = array (i,j);
 A(ik,k) = t*i + A(ik,k);
 B(ik,k) = t*j + B(ik,k);
D(ik,k) = t + D(ik,k);
            end;
        end;
  imean(ik,k) = A(ik,k) / D(ik,k);
  jmean(ik,k) = B(ik,k) / D(ik,k);
  M00(ik,k) = 0;
  M02(ik,k) = 0;
  M11(ik,k) = 0;
  M20(ik,k) = 0;
  M03(ik,k) = 0;
  M12(ik,k) = 0;
  M21(ik,k) = 0;
  M30(ik,k) = 0;
 

% Calculate Moments
for i = 1:25;
      for j = 1:35;
          t = array (i,j);
          M00(ik,k) = (i - imean(ik,k))^0 * (j - jmean(ik,k))^0 * t + M00(ik,k);
           M02(ik,k) = (i - imean(ik,k))^0 * (j - jmean(ik,k))^2 * t + M02(ik,k);
            M11(ik,k) = (i - imean(ik,k))^1 * (j - jmean(ik,k))^1 * t + M11(ik,k);
            M20(ik,k) = (i - imean(ik,k))^2 * (j - jmean(ik,k))^0 * t + M20(ik,k);
            M03(ik,k) = (i - imean(ik,k))^0 * (j - jmean(ik,k))^3 * t + M03(ik,k);
             M12(ik,k) = (i - imean(ik,k))^1 * (j - jmean(ik,k))^2 * t + M12(ik,k);
              M21(ik,k) = (i - imean(ik,k))^2 * (j - jmean(ik,k))^1 * t + M21(ik,k);
               M30(ik,k) = (i - imean(ik,k))^3 * (j - jmean(ik,k))^0 * t + M30(ik,k);
      end ;
  end;
    end;
end;


  sq00=0;
  sq02=0;
  sq11=0;
  sq20=0;
  sq03=0;
  sq12=0;
  sq21=0;
  sq30=0;


%Calculate RMS
  for ik = 1:10;
    for k = 1:10;

sq00 =  M00(ik,k)^2+sq00;
sq02 =  M02(ik,k)^2+sq02;
sq11 =  M11(ik,k)^2+sq11;
sq20 =  M20(ik,k)^2+sq20;
sq03 =  M03(ik,k)^2+sq03;
sq12 =  M12(ik,k)^2+sq12;
sq21 =  M21(ik,k)^2+sq21;
sq30 =  M30(ik,k)^2+sq30;
end; 
end;


sqm00 = sq00/100;
rms00 = sqm00^0.5;
 sqm02 = sq02/100;
rms02 = sqm02^0.5;
 sqm11 = sq11/100;
rms11 = sqm11^0.5;
 sqm20 = sq20/100;
rms20 = sqm20^0.5;
 sqm03 = sq03/100;
rms03 = sqm03^0.5;
 sqm12 = sq12/100;
rms12 = sqm12^0.5;
 sqm21 = sq21/100;
rms21 = sqm21^0.5;
 sqm30 = sq30/100;
rms30 = sqm30^0.5;


%Normalise for RMS

for ik = 1:10 
    for k = 1:10;

N00(ik,k) = M00(ik,k) / rms00;
N02(ik,k) = M02(ik,k) / rms02;
N11(ik,k) = M11(ik,k) / rms11;
N20(ik,k) = M20(ik,k) / rms20;
N03(ik,k) = M03(ik,k) / rms03;
N12(ik,k) = M12(ik,k) / rms12;
N21(ik,k) = M21(ik,k) / rms21;
N30(ik,k) = M30(ik,k) / rms30;
end;
end;

i = 1;
k = 1;
for ui = 1:100
if k == 11;
i = i+1;
k = 1;
end;
X(ui,:) = [N00(i,k), N02(i,k), N11(i,k), N20(i,k), N03(i,k), N12(i,k), N21(i,k), N30(i,k)];
k = k+1;
end;
ida = kmeans(X,9,'distance', 'sqeuclidean', 'emptyaction','singleton');
idb.a = kmeans(X,10, 'distance', 'sqeuclidean', 'emptyaction','singleton');
idc = kmeans(X,11, 'distance', 'sqeuclidean', 'emptyaction','singleton');




%% Starting for B

prompt = 'Enter the file name of the dataset ';
str = input(prompt,'s');
d = 0;
drt =0;
data = load([str]);

arr = [data];
for ik = 1:10;
for k = 1:10;
drt =  25 + drt; 
d = drt;
if ik==1; 
ext = ['a' num2str(k) ];
end;
if ik==2; 
ext = ['c' num2str(k)];
end;
if ik==3; 
ext = ['e' num2str(k)];
end;
if ik==4;
ext = ['m' num2str(k)];
end;
if ik==5;
ext = ['n' num2str(k)];
end;
if ik==6;
ext = ['o' num2str(k)];
end;
if ik==7;
ext = ['r' num2str(k)];
end;
if ik==8;
ext = ['s' num2str(k)];
end;
if ik==9; 
ext = ['x' num2str(k)];
end;
if ik==10;
ext = ['z' num2str(k)];
end;
for j = 1:25;
a(j,:) = arr(d,:);
d=d-1;
end;
h.(ext) = a;

A(ik,k) = 0;
B(ik,k) = 0;
D(ik,k) = 0;
array = h.(ext);
        for i = 1:25;
             for j = 1:35 ;
 t = array (i,j);
 A(ik,k) = t*i + A(ik,k);
 B(ik,k) = t*j + B(ik,k);
D(ik,k) = t + D(ik,k);
            end;
        end;
  imean(ik,k) = A(ik,k) / D(ik,k);
  jmean(ik,k) = B(ik,k) / D(ik,k);
  M00(ik,k) = 0;
  M02(ik,k) = 0;
  M11(ik,k) = 0;
  M20(ik,k) = 0;
  M03(ik,k) = 0;
  M12(ik,k) = 0;
  M21(ik,k) = 0;
  M30(ik,k) = 0;
 

% Calculate Moments
for i = 1:25;
      for j = 1:35;
          t = array (i,j);
          M00(ik,k) = (i - imean(ik,k))^0 * (j - jmean(ik,k))^0 * t + M00(ik,k);
           M02(ik,k) = (i - imean(ik,k))^0 * (j - jmean(ik,k))^2 * t + M02(ik,k);
            M11(ik,k) = (i - imean(ik,k))^1 * (j - jmean(ik,k))^1 * t + M11(ik,k);
            M20(ik,k) = (i - imean(ik,k))^2 * (j - jmean(ik,k))^0 * t + M20(ik,k);
            M03(ik,k) = (i - imean(ik,k))^0 * (j - jmean(ik,k))^3 * t + M03(ik,k);
             M12(ik,k) = (i - imean(ik,k))^1 * (j - jmean(ik,k))^2 * t + M12(ik,k);
              M21(ik,k) = (i - imean(ik,k))^2 * (j - jmean(ik,k))^1 * t + M21(ik,k);
               M30(ik,k) = (i - imean(ik,k))^3 * (j - jmean(ik,k))^0 * t + M30(ik,k);
      end ;
  end;
    end;
end;


%Normalise for RMS

for ik = 1:10 
    for k = 1:10;

N00(ik,k) = M00(ik,k) / rms00;
N02(ik,k) = M02(ik,k) / rms02;
N11(ik,k) = M11(ik,k) / rms11;
N20(ik,k) = M20(ik,k) / rms20;
N03(ik,k) = M03(ik,k) / rms03;
N12(ik,k) = M12(ik,k) / rms12;
N21(ik,k) = M21(ik,k) / rms21;
N30(ik,k) = M30(ik,k) / rms30;
end;
end;

i = 1;
k = 1;
for ui = 1:100
if k == 11;
i = i+1;
k = 1;
end;
X2(ui,:) = [N00(i,k), N02(i,k), N11(i,k), N20(i,k), N03(i,k), N12(i,k), N21(i,k), N30(i,k)];
k = k+1;
end;
idb.b = kmeans(X2,10, 'distance', 'sqeuclidean', 'emptyaction','singleton');


%% Starting for C

prompt = 'Enter the file name of the data';
str = input(prompt,'s');
d = 0;
drt =0;
data = load([str]);

arr = [data];
for ik = 1:10;
for k = 1:10;
drt =  25 + drt; 
d = drt;
if ik==1; 
ext = ['a' num2str(k) ];
end;
if ik==2; 
ext = ['c' num2str(k)];
end;
if ik==3; 
ext = ['e' num2str(k)];
end;
if ik==4;
ext = ['m' num2str(k)];
end;
if ik==5;
ext = ['n' num2str(k)];
end;
if ik==6;
ext = ['o' num2str(k)];
end;
if ik==7;
ext = ['r' num2str(k)];
end;
if ik==8;
ext = ['s' num2str(k)];
end;
if ik==9; 
ext = ['x' num2str(k)];
end;
if ik==10;
ext = ['z' num2str(k)];
end;
for j = 1:25;
a(j,:) = arr(d,:);
d=d-1;
end;
h.(ext) = a;

A(ik,k) = 0;
B(ik,k) = 0;
D(ik,k) = 0;
array = h.(ext);
        for i = 1:25;
             for j = 1:35 ;
 t = array (i,j);
 A(ik,k) = t*i + A(ik,k);
 B(ik,k) = t*j + B(ik,k);
D(ik,k) = t + D(ik,k);
            end;
        end;
  imean(ik,k) = A(ik,k) / D(ik,k);
  jmean(ik,k) = B(ik,k) / D(ik,k);
  M00(ik,k) = 0;
  M02(ik,k) = 0;
  M11(ik,k) = 0;
  M20(ik,k) = 0;
  M03(ik,k) = 0;
  M12(ik,k) = 0;
  M21(ik,k) = 0;
  M30(ik,k) = 0;
 

% Calculate Moments
for i = 1:25;
      for j = 1:35;
          t = array (i,j);
          M00(ik,k) = (i - imean(ik,k))^0 * (j - jmean(ik,k))^0 * t + M00(ik,k);
           M02(ik,k) = (i - imean(ik,k))^0 * (j - jmean(ik,k))^2 * t + M02(ik,k);
            M11(ik,k) = (i - imean(ik,k))^1 * (j - jmean(ik,k))^1 * t + M11(ik,k);
            M20(ik,k) = (i - imean(ik,k))^2 * (j - jmean(ik,k))^0 * t + M20(ik,k);
            M03(ik,k) = (i - imean(ik,k))^0 * (j - jmean(ik,k))^3 * t + M03(ik,k);
             M12(ik,k) = (i - imean(ik,k))^1 * (j - jmean(ik,k))^2 * t + M12(ik,k);
              M21(ik,k) = (i - imean(ik,k))^2 * (j - jmean(ik,k))^1 * t + M21(ik,k);
               M30(ik,k) = (i - imean(ik,k))^3 * (j - jmean(ik,k))^0 * t + M30(ik,k);
      end ;
  end;
    end;
end;


%Normalise for RMS

for ik = 1:10 
    for k = 1:10;

N00(ik,k) = M00(ik,k) / rms00;
N02(ik,k) = M02(ik,k) / rms02;
N11(ik,k) = M11(ik,k) / rms11;
N20(ik,k) = M20(ik,k) / rms20;
N03(ik,k) = M03(ik,k) / rms03;
N12(ik,k) = M12(ik,k) / rms12;
N21(ik,k) = M21(ik,k) / rms21;
N30(ik,k) = M30(ik,k) / rms30;
end;
end;

i = 1;
k = 1;
for ui = 1:100
if k == 11;
i = i+1;
k = 1;
end;
X2(ui,:) = [N00(i,k), N02(i,k), N11(i,k), N20(i,k), N03(i,k), N12(i,k), N21(i,k), N30(i,k)];
k = k+1;
end;

idb.c = kmeans(X2,10, 'distance', 'sqeuclidean', 'emptyaction','singleton');

%% Starting for D

prompt = 'Enter the file name of the dataset ';
str = input(prompt,'s');
d = 0;
drt =0;
data = load([str]);

arr = [data];
for ik = 1:10;
for k = 1:10;
drt =  25 + drt; 
d = drt;
if ik==1; 
ext = ['a' num2str(k) ];
end;
if ik==2; 
ext = ['c' num2str(k)];
end;
if ik==3; 
ext = ['e' num2str(k)];
end;
if ik==4;
ext = ['m' num2str(k)];
end;
if ik==5;
ext = ['n' num2str(k)];
end;
if ik==6;
ext = ['o' num2str(k)];
end;
if ik==7;
ext = ['r' num2str(k)];
end;
if ik==8;
ext = ['s' num2str(k)];
end;
if ik==9; 
ext = ['x' num2str(k)];
end;
if ik==10;
ext = ['z' num2str(k)];
end;
for j = 1:25;
a(j,:) = arr(d,:);
d=d-1;
end;
h.(ext) = a;

A(ik,k) = 0;
B(ik,k) = 0;
D(ik,k) = 0;
array = h.(ext);
        for i = 1:25;
             for j = 1:35 ;
 t = array (i,j);
 A(ik,k) = t*i + A(ik,k);
 B(ik,k) = t*j + B(ik,k);
D(ik,k) = t + D(ik,k);
            end;
        end;
  imean(ik,k) = A(ik,k) / D(ik,k);
  jmean(ik,k) = B(ik,k) / D(ik,k);
  M00(ik,k) = 0;
  M02(ik,k) = 0;
  M11(ik,k) = 0;
  M20(ik,k) = 0;
  M03(ik,k) = 0;
  M12(ik,k) = 0;
  M21(ik,k) = 0;
  M30(ik,k) = 0;
 

% Calculate Moments
for i = 1:25;
      for j = 1:35;
          t = array (i,j);
          M00(ik,k) = (i - imean(ik,k))^0 * (j - jmean(ik,k))^0 * t + M00(ik,k);
           M02(ik,k) = (i - imean(ik,k))^0 * (j - jmean(ik,k))^2 * t + M02(ik,k);
            M11(ik,k) = (i - imean(ik,k))^1 * (j - jmean(ik,k))^1 * t + M11(ik,k);
            M20(ik,k) = (i - imean(ik,k))^2 * (j - jmean(ik,k))^0 * t + M20(ik,k);
            M03(ik,k) = (i - imean(ik,k))^0 * (j - jmean(ik,k))^3 * t + M03(ik,k);
             M12(ik,k) = (i - imean(ik,k))^1 * (j - jmean(ik,k))^2 * t + M12(ik,k);
              M21(ik,k) = (i - imean(ik,k))^2 * (j - jmean(ik,k))^1 * t + M21(ik,k);
               M30(ik,k) = (i - imean(ik,k))^3 * (j - jmean(ik,k))^0 * t + M30(ik,k);
      end ;
  end;
    end;
end;


%Normalise for RMS

for ik = 1:10 
    for k = 1:10;

N00(ik,k) = M00(ik,k) / rms00;
N02(ik,k) = M02(ik,k) / rms02;
N11(ik,k) = M11(ik,k) / rms11;
N20(ik,k) = M20(ik,k) / rms20;
N03(ik,k) = M03(ik,k) / rms03;
N12(ik,k) = M12(ik,k) / rms12;
N21(ik,k) = M21(ik,k) / rms21;
N30(ik,k) = M30(ik,k) / rms30;
end;
end;

i = 1;
k = 1;
for ui = 1:100
if k == 11;
i = i+1;
k = 1;
end;
X3(ui,:) = [N00(i,k), N02(i,k), N11(i,k), N20(i,k), N03(i,k), N12(i,k), N21(i,k), N30(i,k)];
k = k+1;
end;
idb.d = kmeans(X3,10, 'distance', 'sqeuclidean', 'emptyaction','singleton');

runp;
runp1;
diary OFF;

