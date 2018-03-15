diary(str1);

fprintf('\r\n \r\n \r\n  Printing the Confusion Matrices \r\n \r\n');
for ty = 1:4;
if (ty == 1)
fprintf('For dataset A \r\n');
elseif (ty == 2)
fprintf('For dataset B \r\n');
elseif (ty == 3)
fprintf('For dataset C \r\n');
elseif (ty == 4)
fprintf('For dataset D \r\n');
end;
uu = ['ee' num2str(ty)];
%b = int64(conf.(uu));
s.(uu) = transpose(conf.(uu));
ws.(uu) = transpose(confx.(uu));
a = s.(uu);
wa = ws.(uu);
su = sum(s.(uu));
su2 = sum(s.(uu), 2);
wsu = sum(ws.(uu));
wsu2 = sum(ws.(uu), 2);
for i = 1:10;
su = sum(s.(uu));
su2 = sum(s.(uu), 2);
ero1(i).(uu) = su2(i) - a(i,i);
ero2(i).(uu) = su(i) - a(i,i);
wsu = sum(ws.(uu));
wsu2 = sum(ws.(uu), 2);
wero1(i).(uu) = wsu2(i) - wa(i,i);
wero2(i).(uu) = wsu(i) - wa(i,i);
end;
fprintf('\r\n \r\n');
fprintf('NN on Bitmaps of sample \r\n');
fprintf('Classfied as		a	  c	  e	  m	  n	  o	  r	  s	  x	  z 	 Type I Error\r\n');
fprintf('True Class \r\n');
for k = 1:10;
if k==1; 
ext = ['a'  ];
end;
if k==2; 
ext = ['c' ];
end;
if k==3; 
ext = ['e' ];
end;
if k==4;
ext = ['m' ];
end;
if k==5;
ext = ['n' ];
end;
if k==6;
ext = ['o' ];
end;
if k==7;
ext = ['r' ];
end;
if k==8;
ext = ['s' ];
end;
if k==9; 
ext = ['x' ];
end;
if k==10;
ext = ['z' ];
end;
fprintf('%s                       %d         %d       %d       %d       %d       %d       %d       %d       %d       %d           %d       \r\n', ext, a(k,1),  a(k,2), a(k,3), a(k,4), a(k,5), a(k,6), a(k,7), a(k,8), a(k,9), a(k,10), ero1(k).(uu));
end;
fprintf('\r\n');
fprintf('Type II Error            %d       %d       %d       %d       %d       %d       %d       %d       %d       %d                \r\n',ero2(1).(uu),ero2(2).(uu),ero2(3).(uu),ero2(4).(uu),ero2(5).(uu),ero2(6).(uu),ero2(7).(uu),ero2(8).(uu),ero2(9).(uu),ero2(10).(uu) );  

fprintf('\r\n \r\n');
fprintf('5-NN on Bitmaps of sample \r\n');
fprintf('Classfied as		a	  c	  e	  m	  n	  o	  r	  s	  x	  z 	 Type I Error\r\n');
fprintf('True Class \r\n');
for k = 1:10;
if k==1; 
ext = 'a';
end;
if k==2; 
ext = 'c';
end;
if k==3; 
ext = 'e';
end;
if k==4;
ext = 'm';
end;
if k==5;
ext = 'n';
end;
if k==6;
ext = 'o';
end;
if k==7;
ext = 'r';
end;
if k==8;
ext = 's';
end;
if k==9; 
ext = 'x';
end;
if k==10;
ext = 'z';
end;
fprintf('%s                       %d         %d       %d       %d       %d       %d       %d       %d       %d       %d           %d       \r\n', ext, wa(k,1),  wa(k,2), wa(k,3), wa(k,4), wa(k,5), wa(k,6), wa(k,7), wa(k,8), wa(k,9), wa(k,10), wero1(k).(uu));
end;
fprintf('\r\n');
fprintf('Type II Error            %d       %d       %d       %d       %d       %d       %d       %d       %d       %d                \r\n',wero2(1).(uu),wero2(2).(uu),wero2(3).(uu),wero2(4).(uu),wero2(5).(uu),wero2(6).(uu),wero2(7).(uu),wero2(8).(uu),wero2(9).(uu),wero2(10).(uu) );  



  end;
fprintf(' \r\n \r\n ');
%Print The Final table
fprintf('Test Method                 A        B        C       D \r\n');
fprintf('    1                       %d       %d       %d      %d \r\n', err.ee1, err.ee2, err.ee3, err.ee4);
fprintf('    2                       %d       %d       %d      %d \r\n', errx.ee1, errx.ee2, errx.ee3, errx.ee4);
fprintf('    3                       %d       %d       %d      %d \r\n', errw.ee1, errw.ee2, errw.ee3, errw.ee4);
fprintf('    4                       %d       %d       %d      %d \r\n', errwx.ee1, errwx.ee2, errwx.ee3, errwx.ee4);
fprintf(' \r\n \r\n ');