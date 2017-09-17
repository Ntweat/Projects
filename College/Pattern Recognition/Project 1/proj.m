clearvars;

%Get directory and output file name
prompt = 'Enter the path of the dataset ';
str = input(prompt,'s');
cd (str);
prompt = 'Enter the file name for output (along with path, else the file will be saved in the dataset directory) ';
str1 = input(prompt,'s');
diary(str1);
diary ON;

% starting to read files
for c = 0:9;
 for k = 1:10;   

filename = [ num2str(c) '-' num2str(k) ];
if (c == 0);
gv = 9;
else
gv = c - 1;
end;
hello = [ 'a' num2str(gv) num2str(k)];
dataStruct.(hello) = load ([filename]);
array = dataStruct.(hello);



%calculate the imean and jmean 
hi = ['b' num2str(gv)];
A(k).(hi) = 0;
B(k).(hi) = 0;
D(k).(hi) = 0;
        for i = 1:28;
              
            for j = 1:28 ;
 t = array (i,j);
 A(k).(hi) = t*i + A(k).(hi);
 B(k).(hi) = t*j + B(k).(hi);
D(k).(hi) = t + D(k).(hi);
            end;
        end;
  imean(k).(hi) = A(k).(hi) / D(k).(hi);
  jmean(k).(hi) = B(k).(hi) / D(k).(hi);
  M00(k).(hi) = 0;
  M02(k).(hi) = 0;
  M11(k).(hi) = 0;
  M20(k).(hi) = 0;
  M03(k).(hi) = 0;
  M12(k).(hi) = 0;
  M21(k).(hi) = 0;
  M30(k).(hi) = 0;
 

% Calculate Moments
for i = 1:28;
      for j = 1:28;
          t = array (i,j);
          M00(k).(hi) = (i - imean(k).(hi))^0 * (j - jmean(k).(hi))^0 * t + M00(k).(hi);
           M02(k).(hi) = (i - imean(k).(hi))^0 * (j - jmean(k).(hi))^2 * t + M02(k).(hi);
            M11(k).(hi) = (i - imean(k).(hi))^1 * (j - jmean(k).(hi))^1 * t + M11(k).(hi);
            M20(k).(hi) = (i - imean(k).(hi))^2 * (j - jmean(k).(hi))^0 * t + M20(k).(hi);
            M03(k).(hi) = (i - imean(k).(hi))^0 * (j - jmean(k).(hi))^3 * t + M03(k).(hi);
             M12(k).(hi) = (i - imean(k).(hi))^1 * (j - jmean(k).(hi))^2 * t + M12(k).(hi);
              M21(k).(hi) = (i - imean(k).(hi))^2 * (j - jmean(k).(hi))^1 * t + M21(k).(hi);
               M30(k).(hi) = (i - imean(k).(hi))^3 * (j - jmean(k).(hi))^0 * t + M30(k).(hi);
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
    for k = 1:10;
hello2 = [ 'b' num2str(c) ];
sq00 =  M00(k).(hello2)^2+sq00;
sq02 =  M02(k).(hello2)^2+sq02;
sq11 =  M11(k).(hello2)^2+sq11;
sq20 =  M20(k).(hello2)^2+sq20;
sq03 =  M03(k).(hello2)^2+sq03;
sq12 =  M12(k).(hello2)^2+sq12;
sq21 =  M21(k).(hello2)^2+sq21;
sq30 =  M30(k).(hello2)^2+sq30;
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
    for k = 1:10;
hello3 = [ 'b' num2str(c) ];
N00(k).(hello3) = M00(k).(hello3) / rms00;
N02(k).(hello3) = M02(k).(hello3) / rms02;
N11(k).(hello3) = M11(k).(hello3) / rms11;
N20(k).(hello3) = M20(k).(hello3) / rms20;
N03(k).(hello3) = M03(k).(hello3) / rms03;
N12(k).(hello3) = M12(k).(hello3) / rms12;
N21(k).(hello3) = M21(k).(hello3) / rms21;
N20(k).(hello3) = M20(k).(hello3) / rms20;
N30(k).(hello3) = M30(k).(hello3) / rms30;
end
e = c+1;

%Calculate the mean and variance 
B = [N00.(hello3)];
A = transpose(B);
MM00(e) = mean(A);
V00(e) = var(A,1);
B =  [N02.(hello3)];
A = transpose(B);
MM02(e) = mean(A);
V02(e) = var(A,1);
B =  [N11.(hello3)];
A = transpose(B);
MM11(e) = mean(A);
V11(e) = var(A,1);
B =  [N20.(hello3)];
A = transpose(B);
MM20(e) = mean(A);
V20(e) = var(A,1);
B =  [N03.(hello3)];
A = transpose(B);
MM03(e) = mean(A);
V03(e) = var(A,1);
B =  [N12.(hello3)];
A = transpose(B);
MM12(e) = mean(A);
V12(e) = var(A,1);
B =  [N21.(hello3)];
A = transpose(B);
MM21(e) = mean(A);
V21(e) = var(A,1);
B =  [N20.(hello3)];
A = transpose(B);
MM20(e) = mean(A);
V20(e) = var(A,1);
B =  [N30.(hello3)];
A = transpose(B);
MM30(e) = mean(A);
V30(e) = var(A,1);

end;

%Pring Moments
fprintf('           M00      M02       M11      M20  	M03  	 M12  	  M21  	     M30  ');
for c = 0:9;
g = c+ 1;
r = c+ 1;
if g == 10
g = 0;
end;
for k = 1:10
hello3 = [ 'b' num2str(c) ];
fprintf(' \r\n ')
fprintf('%d - %d    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f      \r\n ', g , k, N00(k).(hello3) , N02(k).(hello3) , N11(k).(hello3) , N20(k).(hello3) , N03(k).(hello3) , N12(k).(hello3) , N21(k).(hello3), N30(k).(hello3)  )
end;
fprintf(' \r\n ')
fprintf('mean(%d)   %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f       \r\n', g , MM00(r),  MM02(r), MM11(r), MM20(r), MM03(r), MM12(r), MM21(r),MM30(r))
fprintf(' var(%d)    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f      \r\n ', g , V00(r),  V02(r), V11(r), V20(r), V03(r), V12(r), V21(r),V30(r))
fprintf(' \r\n ')
end;
fprintf(' \r\n \r\n')
fprintf('Overall RMS %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f    %0.3f      \r\n ',  rms00 , rms02 , rms11 , rms20 , rms03 , rms12 , rms21 ,rms30 )
projc;
diary OFF;


