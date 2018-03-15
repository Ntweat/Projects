for cl = 1:4
ur = ['f' num2str(cl)];

for ik = 1:10;
for k = 1:10;
if ik==1; 
ext = ['a' num2str(cl) num2str(k) ];
end;
if ik==2; 
ext = ['c' num2str(cl) num2str(k)];
end;
if ik==3; 
ext = ['e' num2str(cl) num2str(k)];
end;
if ik==4;
ext = ['m' num2str(cl) num2str(k)];
end;
if ik==5;
ext = ['n' num2str(cl) num2str(k)];
end;
if ik==6;
ext = ['o' num2str(cl) num2str(k)];
end;
if ik==7;
ext = ['r' num2str(cl) num2str(k)];
end;
if ik==8;
ext = ['s' num2str(cl) num2str(k)];
end;
if ik==9; 
ext = ['x' num2str(cl) num2str(k)];
end;
if ik==10;
ext = ['z' num2str(cl) num2str(k)];
end;

A(ik,k).(ur) = 0;
B(ik,k).(ur) = 0;
D(ik,k).(ur) = 0;
array = h.(ext);
        for i = 1:25;
             for j = 1:35 ;
 t = array (i,j);
 A(ik,k).(ur) = t*i + A(ik,k).(ur);
 B(ik,k).(ur) = t*j + B(ik,k).(ur);
D(ik,k).(ur) = t + D(ik,k).(ur);
            end;
        end;
  imean(ik,k).(ur) = A(ik,k).(ur) / D(ik,k).(ur);
  jmean(ik,k).(ur) = B(ik,k).(ur) / D(ik,k).(ur);
  M00(ik,k).(ur) = 0;
  M02(ik,k).(ur) = 0;
  M11(ik,k).(ur) = 0;
  M20(ik,k).(ur) = 0;
  M03(ik,k).(ur) = 0;
  M12(ik,k).(ur) = 0;
  M21(ik,k).(ur) = 0;
  M30(ik,k).(ur) = 0;
 

% Calculate Moments
for i = 1:25;
      for j = 1:35;
          t = array (i,j);
          M00(ik,k).(ur) = (i - imean(ik,k).(ur))^0 * (j - jmean(ik,k).(ur))^0 * t + M00(ik,k).(ur);
           M02(ik,k).(ur) = (i - imean(ik,k).(ur))^0 * (j - jmean(ik,k).(ur))^2 * t + M02(ik,k).(ur);
            M11(ik,k).(ur) = (i - imean(ik,k).(ur))^1 * (j - jmean(ik,k).(ur))^1 * t + M11(ik,k).(ur);
            M20(ik,k).(ur) = (i - imean(ik,k).(ur))^2 * (j - jmean(ik,k).(ur))^0 * t + M20(ik,k).(ur);
            M03(ik,k).(ur) = (i - imean(ik,k).(ur))^0 * (j - jmean(ik,k).(ur))^3 * t + M03(ik,k).(ur);
             M12(ik,k).(ur) = (i - imean(ik,k).(ur))^1 * (j - jmean(ik,k).(ur))^2 * t + M12(ik,k).(ur);
              M21(ik,k).(ur) = (i - imean(ik,k).(ur))^2 * (j - jmean(ik,k).(ur))^1 * t + M21(ik,k).(ur);
               M30(ik,k).(ur) = (i - imean(ik,k).(ur))^3 * (j - jmean(ik,k).(ur))^0 * t + M30(ik,k).(ur);
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
if cl == 1;
  for ik = 1:10;
    for k = 1:10;

sq00 =  M00(ik,k).(ur)^2+sq00;
sq02 =  M02(ik,k).(ur)^2+sq02;
sq11 =  M11(ik,k).(ur)^2+sq11;
sq20 =  M20(ik,k).(ur)^2+sq20;
sq03 =  M03(ik,k).(ur)^2+sq03;
sq12 =  M12(ik,k).(ur)^2+sq12;
sq21 =  M21(ik,k).(ur)^2+sq21;
sq30 =  M30(ik,k).(ur)^2+sq30;
end; 
end;


cl;
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
end;

%Normalise for RMS
cl;
for ik = 1:10 
    for k = 1:10;

N00(ik,k).(ur) = M00(ik,k).(ur) / rms00;
N02(ik,k).(ur) = M02(ik,k).(ur) / rms02;
N11(ik,k).(ur) = M11(ik,k).(ur) / rms11;
N20(ik,k).(ur) = M20(ik,k).(ur) / rms20;
N03(ik,k).(ur) = M03(ik,k).(ur) / rms03;
N12(ik,k).(ur) = M12(ik,k).(ur) / rms12;
N21(ik,k).(ur) = M21(ik,k).(ur) / rms21;
%N20(ik,k).(ur) = M20(ik,k).(ur) / rms20;
N30(ik,k).(ur) = M30(ik,k).(ur) / rms30;
end;
end;

u = ['ee' num2str(cl)];
errw.(u) = 0;
errwx.(u) = 0;

for c = 1:10;
for e = 1:10;
for wc = 1:10;
for we = 1:10;
ED(c,e,wc,we).(u) = [[N00(c,e).(ur)-N00(wc,we).f1]^2 + [N02(c,e).(ur)-N02(wc,we).f1]^2+ [N11(c,e).(ur)-N11(wc,we).f1]^2+ [N20(c,e).(ur)-N20(wc,we).f1]^2+ [N03(c,e).(ur)-N03(wc,we).f1]^2+ [N12(c,e).(ur)-N12(wc,we).f1]^2+ [N21(c,e).(ur)-N21(wc,we).f1]^2 + [N30(c,e).(ur)-N30(wc,we).f1]^2];
end;
end;


mini1 = 1000000;
mini2 = 1000000;
mini3 = 1000000;
mini4 = 1000000;
mini5 = 1000000;

P1 = 0;
P2 = 0;
P3 = 0;
P4 = 0;
P5 = 0;
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

predicwx(c,e).(u)= 0;

for t = 1:10;
for tt = 1:10;
testic = ED(c,e,t,tt).(u);
R1 = 0;
R2 = 0;
R3 = 0;
R4 = 0;

if (testic < mini1);
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
Pt5 = P5;
P5 = t;
end;
end;
if (R4 == 1); 
if (temp4 < mini5);
temp5 = mini5;
mini5 = temp4;
P5 = Pt4;
end;
end;
end;
end;

predicw(c,e).(u)= P1;
actualw(c,e).(u) = c;
actualwx(c,e).(u) = c;
 
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
predicwx(c,e).(u)= P1;
end;

if (Pred1 < Pred2 && Pred2 > Pred3 && Pred2 > Pred4 && Pred2 > Pred5);
predicwx(c,e).(u)= P2;
end;

if (Pred1 < Pred3 && Pred2 < Pred3 && Pred3 > Pred4 && Pred3 > Pred5);
predicwx(c,e).(u)= P3;
end;

if (Pred4 > Pred1 && Pred4 > Pred3 && Pred4 > Pred2 && Pred4 > Pred5);
predicwx(c,e).(u)= P4;
end;


if (predicwx(c,e).(u)== 0);
%fprintf('This is there1');

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
predicwx(c,e).(u)= P1;
end;
if ( cnt2 < cnt1 && cnt2 < cnt3 && cnt2 < cnt4 && cnt2 < cnt5 );
predicwx(c,e).(u)= P2;
end;
if ( cnt1 < cnt3 && cnt3 < cnt2 && cnt3 < cnt4 && cnt3 < cnt5 );
predicwx(c,e).(u)= P3;
end;
if ( cnt4 < cnt1 && cnt4 > cnt2 && cnt4 < cnt3 && cnt4 < cnt5 );
predicwx(c,e).(u)= P4;
end;
end;

if (predicwx(c,e).(u)== 0);
if (cnt1 ~= 1000)
predicwx(c,e).(u)== P1;
else
predicwx(c,e).(u)== P2;
end;
end;

aa = predicw(c,e).(u);
bb = actualw(c,e).(u);
bbx = actualwx(c,e).(u);
aax = predicwx(c,e).(u);

if (aa ~= bb);
errw.(u) = errw.(u) + 1;
end;

if (aax ~= bbx);
errwx.(u) = errwx.(u) + 1;
end;

end;
end;
predi = [predicw.(u)];
actu = [actualw.(u)];
confw.(u)  = confusionmat(predi, actu);

predix = [predicwx.(u)];
actux = [actualwx.(u)];
confwx.(u)  = confusionmat(predix, actux);
end;  
