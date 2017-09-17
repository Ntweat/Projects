sumcov = 0;
for (c = 0:9);
if (c == 0);
ik = 10;
else
ik = c;
end;
hello4 = [ 'a' num2str(c)];
for(k = 1:10);
X(ik,k).f0 = [N00(ik,k).f0, N02(ik,k).f0, N11(ik,k).f0, N20(ik,k).f0, N03(ik,k).f0, N12(ik,k).f0, N21(ik,k).f0, N30(ik,k).f0];
end;
rt = cat(1,X(ik,:).f0); %converting data structure to matrix
Y(ik).f0 = rt;

%calculating covariance of the matrix
mh = rt - ones(10,1)*mean(rt); 
po = (mh'*mh)./10;
gf(ik).f0 = po;

%gf(ik).f0 = cov(rt,1);   %used to verify if formula was correct 

ty = gf(ik).f0;
ing = (ty)^(-1);   %inverse of covariance 
ny(ik).f0 = ing;
sumcov = gf(ik).f0 + sumcov ;  %Sum of all covariance
end;

avgcov = sumcov/10;    %average of covariance
inavg = inv(avgcov);     % sum of covariance

% Print print output
%{
for (c = 0:9);
%if (c == 0);
%ik = 10
%else
%ik = c;
%end;
ik = c+1;
km = 0;
fprintf('\r\n')
%hello4 = [ 'a' num2str(l)];
mat1 = cat(1,gf(ik).f0);
mat2 = cat(1,ny(ik).f0);
km = c + 1;

if km == 10;
km = 0;
end;

% Normalise output
df = mat1*100;
yu = mat2*0.001;
fprintf('\r\n');
fprintf('Covariance matrix of the digit (%d) : (multiplier: 100.00)', km );
fprintf('\r\n');
disp(df);

fprintf('\r\n');;
fprintf('Inverse covariance matrix of the digit (%d) : (multiplier: 0.001)', km);
fprintf('\r\n');
disp(yu);
fprintf('\r\n');
end;
fprintf('\r\n');
fprintf('\r\n');
fprintf('Inverse-Cov-Dataset-A');
fprintf('\r\n');
disp(inavg);
fprintf('\r\n');
fprintf('\r\n');
%{
fprintf('Covariance and inverse covariance matrix values at the following index:  (Class 10 is digit 0) ' );
fprintf('\r\n');
fprintf('                            Covariance First Index         Covariance Second Index         Inverse Convariance First           Inverse covariance second');
fprintf('\r\n');
fprintf('Class 1 : [5, 7] , [3, 7]             %0.3f                         %0.3f                          %0.3f                             %0.3f            ', gf.b0(5,7) , gf.b0(3,7), ny.b0(5,7) , ny.b0(3,7) );
fprintf('\r\n');
fprintf('Class 2 : [6, 7] , [5, 1]              %0.3f                         %0.3f                          %0.3f                             %0.3f            ', gf.b1(6,7) , gf.b1(5,1), ny.b1(6,7) , ny.b1(5,1)  );
fprintf('\r\n');
fprintf('Class 3 : [4, 1] , [4, 2]              %0.3f                         %0.3f                          %0.3f                             %0.3f            ', gf.b2(4,1) , gf.b2(4,2), ny.b2(4,1) , ny.b2(4,2) );
fprintf('\r\n');
fprintf('Class 4 : [3, 8] , [2, 5]             %0.3f                         %0.3f                          %0.3f                             %0.3f            ', gf.b3(3,8) , gf.b3(2,5), ny.b3(3,8) , ny.b3(2,5) );
fprintf('\r\n');
fprintf('Class 5 : [3, 5] , [3, 7]             %0.3f                         %0.3f                          %0.3f                             %0.3f            ', gf.b4(3,5) , gf.b4(3,7), ny.b4(3,5) , ny.b4(3,7) );
fprintf('\r\n');
fprintf('Class 6 : [7, 8] , [4, 6]             %0.3f                         %0.3f                          %0.3f                             %0.3f            ', gf.b5(7,8) , gf.b5(4,6),ny.b5(7,8) , ny.b5(4,6)  );
fprintf('\r\n');
fprintf('Class 7 : [3, 5] , [2, 4]             %0.3f                         %0.3f                          %0.3f                             %0.3f            ', gf.b6(3,5) , gf.b6(2,4) ,ny.b6(3,5) , ny.b6(2,4)  );
fprintf('\r\n');
fprintf('Class 8 : [8, 5] , [8, 6]              %0.3f                         %0.3f                          %0.3f                             %0.3f            ', gf.b7(8,5) , gf.b7(8,6) ,ny.b7(8,5) , ny.b7(8,6)  ); 
fprintf('\r\n');
fprintf('Class 9 : [3, 7] , [2, 5]              %0.3f                         %0.3f                          %0.3f                             %0.3f            ', gf.b8(3,7) , gf.b8(2,5) ,ny.b8(3,7) , ny.b8(2,5)  );
fprintf('\r\n');
fprintf('Class 10: [3, 2] , [1, 5]              %0.3f                         %0.3f                          %0.3f                             %0.3f            ', gf.b9(3,2) , gf.b9(1,5) ,ny.b9(3,2) , ny.b9(1,5) );
fprintf('\r\n');
fprintf('\r\n');
fprintf('                     Average covariance and                inverse covariance                   matrix values at ')
fprintf('\r\n');
fprintf(' index:[3,5]                 %0.3f                             %0.3f            ', avgcov(3,5), inavg(3,5));
fprintf('\r\n');
fprintf(' index:[6,3]                 %0.3f                             %0.3f            ', avgcov(6,3), inavg(6,3));

fprintf('\r\n');
fprintf('\r\n');
%}
%}

