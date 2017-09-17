clearvars;

%Get directory and output file name
dforprojm = pwd;
prompt = 'Enter the path of the dataset ';
str = input(prompt,'s');
cd (str);
prompt = 'Enter the file name for output (along with path, else the file will be saved in the dataset directory) ';
str1 = input(prompt,'s');
diary(str1);


% starting to read files
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
hello = [ 'a' num2str(gv) num2str(k)];
dataStruct.(hello) = load ([filename]);
array = dataStruct.(hello);



%calculate the imean and jmean 
hi = ['a' num2str(gv)];
A(ik,k).f0 = 0;
B(ik,k).f0 = 0;
D(ik,k).f0 = 0;
        for i = 1:28;
              
            for j = 1:28 ;
 t = array (i,j);
 A(ik,k).f0 = t*i + A(ik,k).f0;
 B(ik,k).f0 = t*j + B(ik,k).f0;
D(ik,k).f0 = t + D(ik,k).f0;
            end;
        end;
  imean(ik,k).f0 = A(ik,k).f0 / D(ik,k).f0;
  jmean(ik,k).f0 = B(ik,k).f0 / D(ik,k).f0;
  M00(ik,k).f0 = 0;
  M02(ik,k).f0 = 0;
  M11(ik,k).f0 = 0;
  M20(ik,k).f0 = 0;
  M03(ik,k).f0 = 0;
  M12(ik,k).f0 = 0;
  M21(ik,k).f0 = 0;
  M30(ik,k).f0 = 0;
 

% Calculate Moments
for i = 1:28;
      for j = 1:28;
          t = array (i,j);
          M00(ik,k).f0 = (i - imean(ik,k).f0)^0 * (j - jmean(ik,k).f0)^0 * t + M00(ik,k).f0;
           M02(ik,k).f0 = (i - imean(ik,k).f0)^0 * (j - jmean(ik,k).f0)^2 * t + M02(ik,k).f0;
            M11(ik,k).f0 = (i - imean(ik,k).f0)^1 * (j - jmean(ik,k).f0)^1 * t + M11(ik,k).f0;
            M20(ik,k).f0 = (i - imean(ik,k).f0)^2 * (j - jmean(ik,k).f0)^0 * t + M20(ik,k).f0;
            M03(ik,k).f0 = (i - imean(ik,k).f0)^0 * (j - jmean(ik,k).f0)^3 * t + M03(ik,k).f0;
             M12(ik,k).f0 = (i - imean(ik,k).f0)^1 * (j - jmean(ik,k).f0)^2 * t + M12(ik,k).f0;
              M21(ik,k).f0 = (i - imean(ik,k).f0)^2 * (j - jmean(ik,k).f0)^1 * t + M21(ik,k).f0;
               M30(ik,k).f0 = (i - imean(ik,k).f0)^3 * (j - jmean(ik,k).f0)^0 * t + M30(ik,k).f0;
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
  for c = 0:9;
if (c == 0);
ik = 10;
else
ik = c;
end;
    for k = 1:10;

hello2 = [ 'a' num2str(c) ];
sq00 =  M00(ik,k).f0^2+sq00;
sq02 =  M02(ik,k).f0^2+sq02;
sq11 =  M11(ik,k).f0^2+sq11;
sq20 =  M20(ik,k).f0^2+sq20;
sq03 =  M03(ik,k).f0^2+sq03;
sq12 =  M12(ik,k).f0^2+sq12;
sq21 =  M21(ik,k).f0^2+sq21;
sq30 =  M30(ik,k).f0^2+sq30;
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
  for c = 0:9;
if (c == 0);
ik = 10;
else
ik = c;
end;
    for k = 1:10;

hello3 = [ 'a' num2str(c) ];
N00(ik,k).f0 = M00(ik,k).f0 / rms00;
N02(ik,k).f0 = M02(ik,k).f0 / rms02;
N11(ik,k).f0 = M11(ik,k).f0 / rms11;
N20(ik,k).f0 = M20(ik,k).f0 / rms20;
N03(ik,k).f0 = M03(ik,k).f0 / rms03;
N12(ik,k).f0 = M12(ik,k).f0 / rms12;
N21(ik,k).f0 = M21(ik,k).f0 / rms21;
N20(ik,k).f0 = M20(ik,k).f0 / rms20;
N30(ik,k).f0 = M30(ik,k).f0 / rms30;
end
%e = c+1;

%Calculate the mean and variance 
DB = N00(ik,:).f0;
B = [N00(ik,:).f0];
A = transpose(B);
MM00(ik) = mean(A);
V00(ik) = var(A,1);
B =  [N02(ik,:).f0];
A = transpose(B);
MM02(ik) = mean(A);
V02(ik) = var(A,1);
B =  [N11(ik,:).f0];
A = transpose(B);
MM11(ik) = mean(A);
V11(ik) = var(A,1);
B =  [N20(ik,:).f0];
A = transpose(B);
MM20(ik) = mean(A);
V20(ik) = var(A,1);
B =  [N03(ik,:).f0];
A = transpose(B);
MM03(ik) = mean(A);
V03(ik) = var(A,1);
B =  [N12(ik,:).f0];
A = transpose(B);
MM12(ik) = mean(A);
V12(ik) = var(A,1);
B =  [N21(ik,:).f0];
A = transpose(B);
MM21(ik) = mean(A);
V21(ik) = var(A,1);
B =  [N20(ik,:).f0];
A = transpose(B);
MM20(ik) = mean(A);
V20(ik) = var(A,1);
B =  [N30(ik,:).f0];
A = transpose(B);
MM30(ik) = mean(A);
V30(ik) = var(A,1);

end;

%Form the mean matrix
for (pl = 1:10)
hello2 = [ 'm' num2str(pl) ];
Mea.(hello2) = [MM00(pl), MM02(pl), MM11(pl), MM20(pl), MM03(pl), MM12(pl), MM21(pl), MM30(pl)];
end;


%Print Moments
%{
fprintf('           M00      M02       M11      M20  	M03  	 M12  	  M21  	     M30  ');
for c = 0:9;
g = c+ 1;
r = c+ 1;

if g == 10
g = 0;
end;
for k = 1:10
hello3 = [ 'a' num2str(c) ];
fprintf(' \r\n ')
fprintf('%d - %d    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f      \r\n ', g , k, N00(r,k).f0 , N02(r,k).f0 , N11(r,k).f0 , N20(r,k).f0 , N03(r,k).f0 , N12(r,k).f0 , N21(r,k).f0, N30(r,k).f0  )
end;
fprintf(' \r\n ')
fprintf('mean(%d)   %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f       \r\n', g , MM00(r),  MM02(r), MM11(r), MM20(r), MM03(r), MM12(r), MM21(r),MM30(r))
fprintf(' var(%d)    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f      \r\n ', g , V00(r),  V02(r), V11(r), V20(r), V03(r), V12(r), V21(r),V30(r))
fprintf(' \r\n ')
end;
fprintf(' \r\n \r\n')
fprintf('Overall RMS %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f      \r\n ',  rms00 , rms02 , rms11 , rms20 , rms03 , rms12 , rms21 ,rms30 )
%}

cd (dforprojm);

projc;
proj1n;
cd (dforprojm);
proj4;
proj5new;
projp;
diary OFF;


