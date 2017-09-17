
%Define the Gaussian function

Gausff = @(ele, meanc, covc) ((1/(((2*pi)^4)*(det(covc))^0.5))*exp((-0.5)*((ele -meanc)*(covc^(-1))*transpose(ele -meanc))));
Gausf = @(dif, covc) ((1/(((2*pi)^4)*(det(covc))^0.5))*exp((-0.5)*((dif)*(covc^(-1))*transpose(dif))));
%Get names of the Test Datasets
for vb = 1:3
prompt = ['Enter the path of the Test dataset    ' num2str(vb)];
str2 = input(prompt,'s');
data{vb} = str2;
end; 

vb=1;

% Go to all datasets
for vb = 1:3
cd (dforprojm);
str3 = data{vb};
cd (str3);
er = vb+1;
u = ['f' num2str(vb)];

%Read all the files
for c = 0:9;
for k = 1:10;   
filename = [ num2str(c) '-' num2str(k) ];
if (c == 0);
gv = 9;
ik = 10;
else
gv = c - 1;
ik = c;
end;
if (vb == 1);
st = 'b';
elseif ( vb == 2);
st = 'c';
elseif ( vb == 3);
st = 'd';
end;
 
hello = [ st num2str(gv) num2str(k)];
dataStruct2.(u).(hello) = load ([filename]);
array = dataStruct2.(u).(hello);


%calculate the imean and jmean 
hi = [st num2str(gv)];
A1(ik,k).(u) = 0;
B1(ik,k).(u) = 0;
D1(ik,k).(u) = 0;
        for i = 1:28;
              
            for j = 1:28 ;
 t = array (i,j);
 A1(ik,k).(u) = t*i + A1(ik,k).(u);
 B1(ik,k).(u) = t*j + B1(ik,k).(u);
D1(ik,k).(u) = t + D1(ik,k).(u);
            end;
        end;
  imean(ik,k).(u) = A1(ik,k).(u) / D1(ik,k).(u);
  jmean(ik,k).(u) = B1(ik,k).(u) / D1(ik,k).(u);
  M00(ik,k).(u) = 0;
  M02(ik,k).(u) = 0;
  M11(ik,k).(u) = 0;
  M20(ik,k).(u) = 0;
  M03(ik,k).(u) = 0;
  M12(ik,k).(u) = 0;
  M21(ik,k).(u) = 0;
  M30(ik,k).(u) = 0;
 

% Calculate Moments
for i = 1:28;
      for j = 1:28;
          t = array (i,j);
          M00(ik,k).(u) = (i - imean(ik,k).(u))^0 * (j - jmean(ik,k).(u))^0 * t + M00(ik,k).(u);
           M02(ik,k).(u) = (i - imean(ik,k).(u))^0 * (j - jmean(ik,k).(u))^2 * t + M02(ik,k).(u);
            M11(ik,k).(u) = (i - imean(ik,k).(u))^1 * (j - jmean(ik,k).(u))^1 * t + M11(ik,k).(u);
            M20(ik,k).(u) = (i - imean(ik,k).(u))^2 * (j - jmean(ik,k).(u))^0 * t + M20(ik,k).(u);
            M03(ik,k).(u) = (i - imean(ik,k).(u))^0 * (j - jmean(ik,k).(u))^3 * t + M03(ik,k).(u);
             M12(ik,k).(u) = (i - imean(ik,k).(u))^1 * (j - jmean(ik,k).(u))^2 * t + M12(ik,k).(u);
              M21(ik,k).(u) = (i - imean(ik,k).(u))^2 * (j - jmean(ik,k).(u))^1 * t + M21(ik,k).(u);
               M30(ik,k).(u) = (i - imean(ik,k).(u))^3 * (j - jmean(ik,k).(u))^0 * t + M30(ik,k).(u);
      end ;
  end;
    end;
end;

%Normalise for RMS
  for c = 0:9;
if (c == 0);
ik = 10;
else
ik = c;
end;
    for k = 1:10;
hello3 = [ st num2str(c) ];
N00(ik,k).(u) = M00(ik,k).(u) / rms00;
N02(ik,k).(u) = M02(ik,k).(u) / rms02;
N11(ik,k).(u) = M11(ik,k).(u) / rms11;
N20(ik,k).(u) = M20(ik,k).(u) / rms20;
N03(ik,k).(u) = M03(ik,k).(u) / rms03;
N12(ik,k).(u) = M12(ik,k).(u) / rms12;
N21(ik,k).(u) = M21(ik,k).(u) / rms21;
N30(ik,k).(u) = M30(ik,k).(u) / rms30;
end;
end;

%Create array for each element of the Normalised values
for (c = 0:9);
if (c == 0);
ik = 10;
else
ik = c;
end;
for(k = 1:10);
X(ik,k).(u) = [N00(ik,k).(u), N02(ik,k).(u), N11(ik,k).(u), N20(ik,k).(u), N03(ik,k).(u), N12(ik,k).(u), N21(ik,k).(u), N30(ik,k).(u)];
end;
end;
end;


%%%%%%%%%%     Starting the tests     %%%%%%%%%%
for tee = 0:3;
tee;
%if (tee == 0);
%st = 'a';
%elseif (tee == 1);
%st = 'b';
%elseif ( tee == 2);
%st = 'c';
%elseif ( tee == 3);
%st = 'd';
%end;
u = ['f' num2str(tee)];
for (ju = 1:3)
uu = ['f' num2str(tee) num2str(ju)];
err.(uu) = 0;
if ( ju == 1)

%Identity  Covariance
covc = eye(8);
elseif (ju == 2)

%Average Covariance
covc = avgcov;
end;

for (tr = 0:9);
if (tr == 0);
dk = 10;
else
dk = tr;
end;
edr(dk).(uu) = 0;
for (k = 1:10);
for (c = 0:9);
if (c == 0);
ik = 10;
else
ik = c;
end;

%Independent Covariance
if (ju == 3)
covc = gf(ik).f0;
end
hello2 = [ 'm' num2str(ik)];
meny = [Mea.(hello2)];


%Calculating the Probabilities

eleme = [X(dk,k).(u)]; 
dif = eleme - meny;
%pc(dk, k, ik).(uu) = Gausf(eleme, meny, covc);
pc(dk, k, ik).(uu) = Gausf(dif, covc);
end;

%%%%%%%%      Predicting         %%%%%%%%%%

%Assuming it is class 0
maxe = pc(dk, k, 10).(uu); 
pred(dk, k).(uu) = 10; 

%Checking the max probability of item per group
for (io = 1:9)
test = pc(dk, k, io).(uu);
if (maxe < test);
maxe = test;
pred(dk, k).(uu) = io;
end;
end;
act(dk, k).(uu) = dk;
aa = pred(dk,k).(uu);
bb = act(dk,k).(uu); 

%Checking for errors
if (aa ~= bb)
err.(uu) = err.(uu)+1;
edr(dk).(uu) = edr(dk).(uu)+1; 
end;
end;
end;

%{
for (ia = 1:10)
for (ja = 1:10)
predi (ja,ia) = num2str(pred(ja,ia).(uu));
actu (ja,ia) = act(ja,ia).(uu);
end;
end;
%}

%Creating the Confusion Matrix
predi = [pred.(uu)];
actu = [act.(uu)];
conf.(uu)  = confusionmat(predi, actu);
end;
end;
