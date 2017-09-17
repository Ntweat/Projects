%Calculating the errors for printing
%Score tables
diary ON;
fprintf(' \r\n ');
for ( tte = 1:6);
tte;
if (tte <= 4 );
uu = ['f1' num2str(tte)];
if (tte == 1);
strng23 = 'Method 1 - Eight Moments, Identity Covariance Matrix (Trained on A, Tested on B)';
elseif (tte == 2);
strng23 = 'Method 2 - Eight Moments, Identical Covariance Matrix (Trained on A, Tested on B)';
elseif (tte == 3);
strng23 = 'Method 3 - Eight Moments, individual class Covariance Matrix (Trained on A, Tested on B)';
elseif (tte == 4);
strng23 = 'Method 4 - Four Moments, individual class Covariance Matrix (Trained on A, Tested on B)';
end;
end;
% array = [pc.(uu)];
eer1 = [err.(uu)];
if (tte == 5);
strng23 = 'Method 5 - Minimum Distance Classifier in binary pixel space (Trained on A, Tested on B)';
array = [ED.f1];
%eer1 = [erric.f0];
eer1 = [eeric.f1];
elseif (tte == 6);
strng23 = 'Method 6 - Bayes classifier in Binary pixel  space (Trained on A, Tested on B)';
array = [G.f1];
%eer1 = [erricx.f0];
eer1 = [eeric.f1];
end;
if (tte < 5)
fprintf(' \r\n \r\n ');
fprintf('                    %s                                     \r\n \r\n ', strng23);
fprintf('             1 	2	  3	    4	       5	   6	      7	         8	     9	       0 	      	Errors\r\n');
for clas = 1:10;
fprintf(' \r\n');
if clas == 10;
dk = 0;
else; 
dk = clas;
end;
fprintf('													                     Errors %d\r\n', edr(clas).(uu));
for k = 1:10;
fprintf('%d - %d    %0.1d    %0.1d    %0.1d    %0.1d    %0.1d    %0.1d    %0.1d    %0.1d    %0.1d    %0.1d      \r\n ', clas , k, pc(clas, k, 1).(uu), pc(clas, k, 2).(uu), pc(clas, k, 3).(uu), pc(clas, k, 4).(uu), pc(clas, k, 5).(uu), pc(clas, k, 6).(uu), pc(clas, k, 7).(uu), pc(clas, k, 8).(uu), pc(clas, k, 9).(uu), pc(clas, k, 10).(uu) );  
end;
end;
else;
fprintf(' \r\n \r\n ');
fprintf('                    %s                                     \r\n \r\n ', strng23);
fprintf('             1 	2	  3	    4	       5	   6	      7	         8	     9	       0 	      	Errors\r\n');
for clas = 1:10;
fprintf(' \r\n');
fprintf('													                    Errors %d      \r\n', eer1(clas));
if clas == 10;
dk = 0;
else; 
dk = clas;
end;
for k = 1:10;
if (tte == 5);
fprintf('%d - %d    %0.1d    %0.1d    %0.1d    %0.1d    %0.1d    %0.1d    %0.1d    %0.1d    %0.1d    %0.1d      \r\n ', clas , k, ED(clas, 1, k).f1, ED(clas, 2, k).f1, ED(clas, 3, k).f1, ED(clas, 4, k).f1, ED(clas, 5, k).f1, ED(clas, 6, k).f1, ED(clas, 7, k).f1, ED(clas, 8, k).f1, ED(clas, 9, k).f1, ED(clas, 10, k).f1);
else;
fprintf('%d - %d    %0.1d    %0.1d    %0.1d    %0.1d    %0.1d    %0.1d    %0.1d    %0.1d    %0.1d    %0.1d      \r\n ', clas , k, G(clas, 1, k).f1, G(clas, 2, k).f1, G(clas, 3, k).f1, G(clas, 4, k).f1, G(clas, 5, k).f1, G(clas, 6, k).f1, G(clas, 7, k).f1, G(clas, 8, k).f1, G(clas, 9, k).f1, G(clas, 10, k).f1);
end;
  
end;
end;
end;
end;

%Confusion Matrix
fprintf('\r\n \r\n \r\n  Printing the Confusion Matrices \r\n \r\n');
for ty = 0:3;
if (ty == 0)
fprintf('For dataset A \r\n');
elseif (ty == 1)
fprintf('For dataset B \r\n');
elseif (ty == 2)
fprintf('For dataset C \r\n');
elseif (ty == 3)
fprintf('For dataset D \r\n');
end;
uu = ['f' num2str(ty) '1'];
%b = int64(conf.(uu));
s.(uu) = transpose(conf.(uu));
a = s.(uu);
su = sum(s.(uu));
su2 = sum(s.(uu), 2);
for i = 1:10;
su = sum(s.(uu));
su2 = sum(s.(uu), 2);
ero1(i).(uu) = su2(i) - a(i,i);
ero2(i).(uu) = su(i) - a(i,i);
end;
fprintf('\r\n \r\n');
fprintf('Classfied as		1	  2	  3	  4	  5	  6	  7	  8	  9	  0 	 Type I Error\r\n');
fprintf('True Class \r\n');
for k = 1:10
fprintf('%d                       %d         %d       %d       %d       %d       %d       %d       %d       %d       %d           %d       \r\n', k, a(k,1),  a(k,2), a(k,3), a(k,4), a(k,5), a(k,6), a(k,7), a(k,8), a(k,9), a(k,10), ero1(k).(uu));
end;
fprintf('\r\n');
fprintf('Type II Error            %d       %d       %d       %d       %d       %d       %d       %d       %d       %d                \r\n',ero2(1).(uu),ero2(2).(uu),ero2(3).(uu),ero2(4).(uu),ero2(5).(uu),ero2(6).(uu),ero2(7).(uu),ero2(8).(uu),ero2(9).(uu),ero2(10).(uu) );  
  end;
fprintf(' \r\n \r\n ');
%Print The Final table
fprintf('Test Method                 A        B        C       D \r\n');
fprintf('    1                       %d       %d       %d      %d \r\n', err.f01, err.f11, err.f21, err.f31);
fprintf('    2                       %d       %d       %d      %d \r\n', err.f02, err.f12, err.f22, err.f32);
fprintf('    3                       %d       %d       %d      %d \r\n', err.f03, err.f13, err.f23, err.f33);
fprintf('    4                       %d       %d       %d      %d \r\n', err.f04, err.f14, err.f24, err.f34);
fprintf('    5                       %d       %d       %d      %d \r\n', erric.f0, erric.f1, erric.f2, erric.f3);
fprintf('    6                       %d       %d       %d      %d \r\n', erricx.f0, erricx.f1, erricx.f2, erricx.f3);
fprintf(' \r\n \r\n ');
