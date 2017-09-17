%% trainer
for j= 1:28;
for i = 1:28; 
for c = 0:9;
if (c == 0);
gv = 9;
ik = 10;
else
gv = c - 1;
ik = c;
end;
moha(ik,i,j)=0;
for k=1:10;
hello = [ 'a' num2str(gv) num2str(k)];
array = dataStruct.(hello);
moha(ik,i,j)= moha(ik,i,j)+array(i,j);
end;
moha(ik,i,j) = moha(ik,i,j) + 1;
p(ik,i,j)= moha(ik,i,j)/12;
end;
end;
end;

%classifier 

for tee = 0:3;
u = ['f' num2str(tee)];
erric.(u) = 0;
erricx.(u) = 0;
for (tr = 0:9);
if(tr == 0);
gv = 9;
dk = 10;
else 
gv = tr - 1;
dk = tr;
end;
eeric(dk).(u) = 0;
eericx(dk).(u) = 0;
for k=1:10;
if (tee == 0)
hello = [ 'a' num2str(gv) num2str(k)]; 
array = dataStruct.(hello);
elseif (tee == 1);
st = 'b';
elseif ( tee == 2);
st = 'c';
elseif ( tee == 3);
st = 'd';
end;
if ( tee ~= 0); 
hello = [ st num2str(gv) num2str(k)];
array = dataStruct2.(u).(hello);
end;
for c = 0:9;
if (c == 0);
%gv = 9;
ik = 10;
else
%gv = c - 1;
ik = c;
end;
ED(dk,ik,k).(u)= 0;
G(dk,ik,k).(u)= 0;

for i= 1:28;
for j = 1:28;
Telem = array(i,j);
Tprob = p(ik,i,j);
ED(dk,ik,k).(u) = (array(i,j)-p(ik,i,j))^2+ED(dk,ik,k).(u);
G(dk,ik,k).(u)= (Telem*log(Tprob)+(1 - Telem)*log(1-Tprob)) + G(dk,ik,k).(u);
end;
end;
end;
mini = ED(dk,10,k).(u);
maxi = G(dk,10,k).(u);
predic(dk,k).(u)=10;
predicx(dk,k).(u)= 10;

for (io=1:9);
testic = ED(dk,io,k).(u);
testicx = G(dk,io,k).(u);

if (testic < mini);
mini = testic;
predic(dk,k).(u)= io;
end;
if (maxi < testicx);
maxi = testicx;
predicx(dk,k).(u) = io;
end;
end;
actic(dk,k).(u)= dk;
acticx(dk,k).(u)= dk;
aaa = predic(dk,k).(u);
aaax = predicx(dk,k).(u);
bbb = actic(dk,k).(u);
bbbx = acticx(dk,k).(u);

% checking for errors 

if(aaa ~= bbb)
erric.(u) = erric.(u)+1;
eeric(dk).(u) = eeric(dk).(u) + 1;
end;
if (aaax ~= bbbx)
ik;
erricx.(u) = erricx.(u)+1;
eericx(dk).(u) = eericx(dk).(u)+1;
end;
end;
end;

% creating the confusion matrix 

predici = [predic.(u)];
predicix = [predicx.(u)];
actici = [actic.(u)];
acticix = [acticx.(u)];
confic.(u) = confusionmat(predici, actici);
conficx.(u) = confusionmat(predicix, acticix);
end;
