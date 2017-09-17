
for (pl = 1:10)
hello2 = [ 'm' num2str(pl) ];
Nea.(hello2) = [MM00(pl), MM02(pl), MM11(pl), MM20(pl)];
end;

for vb = 0:3
u = ['f' num2str(vb)];
for (c = 0:9);
if (c == 0);
ik = 10;
else
ik = c;
end;
for(k = 1:10);
Z(ik,k).(u) = [N00(ik,k).(u), N02(ik,k).(u), N11(ik,k).(u), N20(ik,k).(u)];
end;
end;
end;

%Calculate covariance of 4 moments
for (c = 0:9);
if (c == 0);
ik = 10;
else
ik = c;
end;
%for(k = 1:10);
rtt = cat(1,Z(ik,:).f0);
mhh = rtt - ones(10,1)*mean(rtt); 
poo = (mhh'*mhh)./10;
gff(ik).f0 = poo;
%end;
end;

%%%%%%%%%%     Starting the tests     %%%%%%%%%%
for tee = 0:3;
tee;
if (tee == 0);
st = 'a';
elseif (tee == 1);
st = 'b';
elseif ( tee == 2);
st = 'c';
elseif ( tee == 3);
st = 'd';
end;
u = ['f' num2str(tee)];
ju = 4;
uu = ['f' num2str(tee) num2str(ju)];
err.(uu) = 0;

for (tr = 0:9);
if (tr == 0);
dk = 10;
else
dk = tr;
end;
edr(dk).(uu) = 0;
for (k = 1:10)
for (c = 0:9);
if (c == 0);
ik = 10;
else
ik = c;
end;
covc = gff(ik).f0;
hello2 = [ 'm' num2str(ik)];
meny = [Nea.(hello2)];

%Calculating the Probabilities
pc(dk, k, ik).(uu) = Gausff(Z(dk,k).(u), meny, covc);
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

