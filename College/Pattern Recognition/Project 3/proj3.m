clearvars;
%fprintf ('new');
%Get directory and output file name
dforprojm = pwd;
prompt = 'Enter the file name of the dataset ';
str = input(prompt,'s');

data.f1 = load([str]);
prompt = 'Enter the file name for output (along with path, else the file will be saved in the dataset directory) ';
str1 = input(prompt,'s');


for vb = 2:4;
prompt = ['Enter the file name of the Test dataset  ' num2str(vb) '  '];
str2 = input(prompt,'s');
ui = ['f' num2str(vb)];
data.(ui) = load([str2]);
end; 

for z = 1:4;
d = 0;
drt = 0;
ue = ['f' num2str(z)];
arr = [data.(ue)];
for i=1:10;
for k=1:10;
%d = 25*i*k
drt =  25 + drt; 
d = drt;
if i==1; 
ext = ['a' num2str(z) num2str(k) ];
end;
if i==2; 
ext = ['c' num2str(z) num2str(k)];
end;
if i==3; 
ext = ['e' num2str(z) num2str(k)];
end;
if i==4;
ext = ['m' num2str(z) num2str(k)];
end;
if i==5;
ext = ['n' num2str(z) num2str(k)];
end;
if i==6;
ext = ['o' num2str(z) num2str(k)];
end;
if i==7;
ext = ['r' num2str(z) num2str(k)];
end;
if i==8;
ext = ['s' num2str(z) num2str(k)];
end;
if i==9; 
ext = ['x' num2str(z) num2str(k)];
end;
if i==10;
ext = ['z' num2str(z) num2str(k)];
end;

for j = 1:25;
%for rr = 1:35;
a(j,:) = arr(d,:);
%end;
d=d-1;
end;
h.(ext) = a;
end;
end;
end;

for zz = 1:4;
u = ['ee' num2str(zz)];
err.(u) = 0;
errx.(u) = 0;
for b = 1:10;
for c = 1:10;
if b==1; 
ext = ['a' num2str(zz) num2str(c) ];
end;
if b==2; 
ext = ['c' num2str(zz) num2str(c)];
end;
if b==3; 
ext = ['e' num2str(zz) num2str(c)];
end;
if b==4;
ext = ['m' num2str(zz) num2str(c)];
end;
if b==5;
ext = ['n' num2str(zz) num2str(c)];
end;
if b==6;
ext = ['o' num2str(zz) num2str(c)];
end;
if b==7;
ext = ['r' num2str(zz) num2str(c)];
end;
if b==8;
ext = ['s' num2str(zz) num2str(c)];
end;
if b==9;
ext = ['x' num2str(zz) num2str(c)];
end;
if b==10;
ext = ['z' num2str(zz) num2str(c)];
end;
%ext
a1 = [h.(ext)];
qq = ext;

for ii = 1:10;
for kk = 1:10;
if ii==1;
ext2 = ['a1' num2str(kk) ];
end;
if ii==2; 
ext2 = ['c1' num2str(kk) ];
end;
if ii==3;
ext2 = ['e1' num2str(kk) ];
end;
if ii==4;
ext2 = ['m1' num2str(kk) ];
end;
if ii==5;
ext2 = ['n1' num2str(kk) ];
end;
if ii==6;
ext2 = ['o1' num2str(kk) ];
end;
if ii==7;
ext2 = ['r1' num2str(kk) ];
end;
if ii==8;
ext2 = ['s1' num2str(kk) ];
end;
if ii==9; 
ext2 = ['x1' num2str(kk) ];
end;
if ii==10;
ext2 = ['z1' num2str(kk) ];
end;
dd = ext2;
ED(ii,kk).(ext) = 0;
a2 = [h.(ext2)];

for r = 1:25;
for q = 1:35;


bx = a1(r,q);
ax = a2(r,q);
kke = bx - ax;
kkk = kke^2;
%{
if bx == 1;
if ax == 0;
asp = bx
asd = ax
end;
end;
%}
ED(ii,kk).(ext) = kkk + ED(ii,kk).(ext);
end;
end;
end;
end;

%ED(z,b,c,ii,kk)
predic(ii,kk).(u)=0;
%predicx(ii,kk).(u)= 10;

mini1 = 1000000;
mini2 = 1000000;
mini3 = 1000000;
mini4 = 1000000;
mini5 = 1000000;

P1 = 1;
P2 = 1;
P3 = 1;
P4 = 1;
P5 = 1;
temp = 0; 
temp2 = 0; 
temp3 = 0; 
temp4 = 0;
temp5 = 0;
Pred1 = 1;
Pred2 = 1;
Pred3 = 1;
Pred4 = 1;
Pred5 = 1;
cnt1 = 1;
cnt2 = 2;
cnt3 = 3;
cnt4 = 4;
cnt5 = 5;

predicx(b,c).(u)= 0;

for t = 1:10;
for tt = 1:10;
testic = ED(t,tt).(ext);
R1 = 0;
R2 = 0;
R3 = 0;
R4 = 0;

if (testic < mini1);
%mini1
%testic
temp = mini1;
Pt = P1;
mini1 = testic;
R1 = 1;
P1 = t;
end;

if (testic < mini2);
if (R1 == 0);
temp2 = mini2;
mini2 = testic;
R2 = 1;
Pt2 = P2;
P2 = t;
end;
end;

if (R1 == 1);
if (temp < mini2);
temp2 = mini2;
mini2 = temp;
R2 = 1;
Pt2 = P2;
P2 = Pt;
end;
end;

if (testic < mini3);
if (R2 == 0);
temp3 = mini3;
mini3 = testic;
R3 = 1;
Pt3 = P3;
P3 = t;
end;
end;

if (R2 == 1);
if (temp2 < mini3);
temp3 = mini3;
mini3 = temp2;
R3 = 1;
Pt3 = P3;
P3 = Pt2;
end;
end;

if (testic < mini4);
if (R3 == 0);
temp4 = mini4;
mini4 = testic;
R4 = 1;
Pt4 = P4;
P4 = t;
end;
end;

if (R3 == 1);
if (temp3 < mini4);
temp4 = mini4;
mini4 = temp3;
R4 = 1;
Pt4 = P4;
P4 = Pt3;
end;
end;

if (testic < mini5);
if (R4 == 0);
temp5 = mini5;
mini5 = testic;
R5 = 1;
Pt5 = P5;
P5 = t;
end;
end;
if (R4 == 1);
if (temp4 < mini5);
temp5 = mini5;
mini5 = temp4;
R3 = 1;
P5 = Pt4;
end;
end;
end;
end;

predic(b,c).(u)= P1;
actual(b,c).(u) = b;
actualx(b,c).(u) = b;
 
if (P1 == P2);
Pred1 = Pred1+1;
Pred2 = 0;
cnt1 = cnt1 + cnt2;
cnt2 = 1000;
end;
if (P1 == P3);
Pred1 = Pred1+1;
cnt1 = cnt1 + cnt3;
cnt3 = 1000;
Pred3 = 0;
end;
if (P1 == P4);
Pred1 = Pred1+1;
Pred4 = 0;
cnt1 = cnt1 + cnt4;
cnt4 = 1000;
end;
if (P1 == P5);
Pred1 = Pred1+1;
cnt1 = cnt1 + cnt5;
cnt5 = 1000;
Pred5 = 0;
end;

if (Pred2 ~= 0);
if (P2 == P3);
Pred2 = Pred2+1;
cnt2 = cnt2 + cnt3;
cnt3 = 1000;
Pred3 = 0;
end;
if (P2 == P4);
Pred2 = Pred2+1;
cnt2 = cnt2 + cnt4;
cnt4 = 1000;
Pred4 = 0;
end;
if (P2 == P5);
Pred2 = Pred2+1;
cnt2 = cnt2 + cnt5;
cnt5 = 1000;
Pred5 = 0;
end;
end;

if (Pred3 ~= 0);
if (P3 == P4);
Pred3 = Pred3+1;
Pred4 = 0;
cnt3 = cnt3 + cnt4;
cnt4 = 1000;
end;
if (P3 == P5);
Pred3 = Pred3+1;
cnt3 = cnt3 + cnt5;
cnt5 = 1000;
Pred5 = 0;
end;
end;

if (Pred4 ~= 0);
if (P4 == P5);
Pred4 = Pred4+1;
cnt4 = cnt4 + cnt5;
cnt5 = 1000;
Pred5 = 0;
end;
end;

if (Pred1 > Pred2 && Pred1 > Pred3 && Pred1 > Pred4 && Pred1 > Pred5);
predicx(b,c).(u)= P1;
end;

if (Pred1 < Pred2 && Pred2 > Pred3 && Pred2 > Pred4 && Pred2 > Pred5);
predicx(b,c).(u)= P2;
end;

if (Pred1 < Pred3 && Pred2 < Pred3 && Pred3 > Pred4 && Pred3 > Pred5);
predicx(b,c).(u)= P3;
end;

if (Pred4 > Pred1 && Pred4 > Pred3 && Pred4 > Pred2 && Pred4 > Pred5);
predicx(b,c).(u)= P4;
end;


if (predicx(b,c).(u)== 0);
%fprintf('This is there');
if (cnt1 == 1);
cnt1 = 1000;
end;
if (cnt2 == 2);
cnt2 = 1000;
end;
if (cnt3 == 3);
cnt3 = 1000;
end;
if (cnt4 == 4);
cnt4 = 1000;
end;
if (cnt5 == 5);
cnt5 = 1000;
end;
if ( cnt1 < cnt2 && cnt1 < cnt3 && cnt1 < cnt4 && cnt1 < cnt5 );
predicx(b,c).(u)= P1;
end;
if ( cnt1 > cnt2 && cnt2 < cnt3 && cnt2 < cnt4 && cnt2 < cnt5 );
predicx(b,c).(u)= P2;
end;
if ( cnt3 < cnt1 && cnt2 > cnt3 && cnt3 < cnt4 && cnt3 < cnt5 );
predicx(b,c).(u)= P3;
end;
if ( cnt4 < cnt1 && cnt2 > cnt4 && cnt4 < cnt3 && cnt4 < cnt5 );
predicx(b,c).(u)= P4;
end;
end;
if (predicx(b,c).(u)== 0);
%{
fprintf('\r\n  ERROR');
P1
cnt1
Pred1
P2
cnt2
Pred2
P3
cnt3
Pred3
P4
cnt4
Pred4
P5
cnt5
Pred5
%}
if (cnt1 ~= 1000)
predicx(b,c).(u)== P1;

else
predicx(b,c).(u)== P2;

end;
end;

aa = predic(b,c).(u);
bb = actual(b,c).(u);
bbx = actualx(b,c).(u);
aax = predicx(b,c).(u);

if (aa ~= bb);
err.(u) = err.(u) + 1;
end;

if (aax ~= bbx);
errx.(u) = errx.(u) + 1;
end;
end;
end;
predi = [predic.(u)];
actu = [actual.(u)];
conf.(u)  = confusionmat(predi, actu);

predix = [predicx.(u)];
actux = [actualx.(u)];
confx.(u)  = confusionmat(predix, actux);
end;

pro3co;
proj3p;

