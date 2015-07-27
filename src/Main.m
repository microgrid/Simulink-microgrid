
%%%%%%%%%%%%%%%%
% Main program %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%

% Construct a questdlg with two options
choice = questdlg('Hello, please choose your Operating System?', ...
'Operating System', ...
'Mac','Windows','Linux','');

% Handle response
global os
switch choice
case 'Mac'
    os = 1;
case 'Windows'
    os = 2;
case 'Linux'
    os=1;  
end

% Create the data insolation to plot from excel
SampleTime=0.1;
xdiscretized=1:SampleTime:24;
Insolation_data = normpdf(xdiscretized,12,1.7); % Normal law
Ins_Monsoon=Insolation_data*3990;
Ins_Intermediate=Insolation_data*4583;
Ins_Winter=Insolation_data*4888;

% Path choise according the OS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if os==1

% Import data from the files for Mac %

customerAllMonsoon=importdata('dataBase/PowerAllMonsoon.mat'); %  Data from excel Block All
customerAllIntermediate=importdata('dataBase/PowerAllIntermediate.mat'); %  Data from excel Block All
customerAllWinter=importdata('dataBase/PowerAllWinter.mat'); %  Data from excel Block All

customerDMonsoon=importdata('dataBase/PowerDMonsoon.mat'); %  Data from excel Block D
customerDIntermediate=importdata('dataBase/PowerDIntermediate.mat'); %  Data from excel Block D
customerDWinter=importdata('dataBase/PowerDWinter.mat'); %  Data from excel Block D

customerEMonsoon=importdata('dataBase/PowerEMonsoon.mat'); %  Data from excel Block E
customerEIntermediate=importdata('dataBase/PowerEIntermediate.mat'); %  Data from excel Block E
customerEWinter=importdata('dataBase/PowerEWinter.mat'); %  Data from excel Block E

customerCMonsoon=importdata('dataBase/PowerCMonsoon.mat'); %  Data from excel Block C
customerCIntermediate=importdata('dataBase/PowerCIntermediate.mat'); %  Data from excel Block C
customerCWinter=importdata('dataBase/PowerCWinter.mat'); %  Data from excel Block C

customerAMonsoon=importdata('dataBase/PowerAMonsoon.mat'); %  Data from excel Block A
customerAIntermediate=importdata('dataBase/PowerAIntermediate.mat'); %  Data from excel Block A
customerAWinter=importdata('dataBase/PowerAWinter.mat'); %  Data from excel Block A

customerBMonsoon=importdata('dataBase/PowerBMonsoon.mat'); %  Data from excel Block B
customerBIntermediate=importdata('dataBase/PowerBIntermediate.mat'); %  Data from excel Block B
customerBWinter=importdata('dataBase/PowerBWinter.mat'); %  Data from excel Block B

customerLHMonsoon=importdata('dataBase/PowerLHMonsoon.mat'); %  Data from excel Block LH
customerLHIntermediate=importdata('dataBase/PowerLHIntermediate.mat'); %  Data from excel Block LH
customerLHWinter=importdata('dataBase/PowerLHWinter.mat'); %  Data from excel Block LH

customerRHMonsoon=importdata('dataBase/PowerRHMonsoon.mat'); %  Data from excel Block RH
customerRHIntermediate=importdata('dataBase/PowerRHIntermediate.mat'); %  Data from excel Block RH
customerRHWinter=importdata('dataBase/PowerRHWinter.mat'); %  Data from excel Block RH

Time=importdata('dataBase/SampleT.mat');     % SampleT.mat Data from excel 
jpg=imread('img/bhutan.jpg');

elseif os==2

% Import data from the files for Window % 

customerAllMonsoon=importdata('dataBase\PowerAllMonsoon.mat'); %  Data from excel Block All
customerAllIntermediate=importdata('dataBase\PowerAllIntermediate.mat'); %  Data from excel Block All
customerAllWinter=importdata('dataBase\PowerAllWinter.mat'); %  Data from excel Block All

customerDMonsoon=importdata('dataBase\PowerDMonsoon.mat'); %  Data from excel Block D
customerDIntermediate=importdata('dataBase\PowerDIntermediate.mat'); %  Data from excel Block D
customerDWinter=importdata('dataBase\PowerDWinter.mat'); %  Data from excel Block D

customerEMonsoon=importdata('dataBase\PowerEMonsoon.mat'); %  Data from excel Block E
customerEIntermediate=importdata('dataBase\PowerEIntermediate.mat'); %  Data from excel Block E
customerEWinter=importdata('dataBase\PowerEWinter.mat'); %  Data from excel Block E

customerCMonsoon=importdata('dataBase\PowerCMonsoon.mat'); %  Data from excel Block C
customerCIntermediate=importdata('dataBase\PowerCIntermediate.mat'); %  Data from excel Block C
customerCWinter=importdata('dataBase\PowerCWinter.mat'); %  Data from excel Block C

customerAMonsoon=importdata('dataBase\PowerAMonsoon.mat'); %  Data from excel Block A
customerAIntermediate=importdata('dataBase\PowerAIntermediate.mat'); %  Data from excel Block A
customerAWinter=importdata('dataBase\PowerAWinter.mat'); %  Data from excel Block A

customerBMonsoon=importdata('dataBase\PowerBMonsoon.mat'); %  Data from excel Block B
customerBIntermediate=importdata('dataBase\PowerBIntermediate.mat'); %  Data from excel Block B
customerBWinter=importdata('dataBase\PowerBWinter.mat'); %  Data from excel Block B

customerLHMonsoon=importdata('dataBase\PowerLHMonsoon.mat'); %  Data from excel Block LH
customerLHIntermediate=importdata('dataBase\PowerLHIntermediate.mat'); %  Data from excel Block LH
customerLHWinter=importdata('dataBase\PowerLHWinter.mat'); %  Data from excel Block LH

customerRHMonsoon=importdata('dataBase\PowerRHMonsoon.mat'); %  Data from excel Block RH
customerRHIntermediate=importdata('dataBase\PowerRHIntermediate.mat'); %  Data from excel Block RH
customerRHWinter=importdata('dataBase\PowerRHWinter.mat'); %  Data from excel Block RH

Time=importdata('dataBase\SampleT.mat');     % SampleT.mat Data from excel 
jpg=imread('img\bhutan.jpg');

end

% linear regression with a polynomial approach for the Active power of the load  

% Block All (Monsoon)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerAllMonsoon,10); % Data choice from pushbutton SEASONS
yfit1 = polyval(p,Time);
yfitdiscretized1=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
nrows = 1;
ncols = (23/SampleTime)+1;
newyfitdiscretized1=yfitdiscretized1;
r=1;
for c = 1:ncols

    if  yfitdiscretized1(r,c)<0
        newyfitdiscretized1(r,c) = 0;
    else
newyfitdiscretized1(r,c)= yfitdiscretized1(r,c);
    end
end

% Block All (Intermediate)
p = polyfit(Time,customerAllIntermediate,10); % Data choice from pushbutton SEASONS
yfit2 = polyval(p,Time);
yfitdiscretized2=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
newyfitdiscretized2=yfitdiscretized2;
r=1;
for c = 1:ncols

    if  yfitdiscretized2(r,c)<0
        newyfitdiscretized2(r,c) = 0;
    else
newyfitdiscretized2(r,c)= yfitdiscretized2(r,c);
    end
end

% Block All (Winter)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerAllWinter,10); % Data choice from pushbutton SEASONS
yfit3 = polyval(p,Time);
yfitdiscretized3=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
nrows = 1;
ncols = (23/SampleTime)+1;
newyfitdiscretized3=yfitdiscretized3;
r=1;
for c = 1:ncols

    if  yfitdiscretized3(r,c)<0
        newyfitdiscretized3(r,c) = 0;
    else
newyfitdiscretized3(r,c)= yfitdiscretized3(r,c);
    end
end

  % Block D (Monsoon)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerDMonsoon,10); % Data choice from pushbutton SEASONS
yfit4 = polyval(p,Time);
yfitdiscretized4=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
nrows = 1;
ncols = (23/SampleTime)+1;
newyfitdiscretized4=yfitdiscretized4;
r=1;
for c = 1:ncols

    if  yfitdiscretized4(r,c)<0
        newyfitdiscretized4(r,c) = 0;
    else
newyfitdiscretized4(r,c)= yfitdiscretized4(r,c);
    end
end

% Block D (Intermediate)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerDIntermediate,10); % Data choice from pushbutton SEASONS
yfit5 = polyval(p,Time);
yfitdiscretized5=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
newyfitdiscretized5=yfitdiscretized5;
r=1;
for c = 1:ncols

    if  yfitdiscretized5(r,c)<0
        newyfitdiscretized5(r,c) = 0;
    else
newyfitdiscretized5(r,c)= yfitdiscretized5(r,c);
    end
end

% Block D (Winter)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerDWinter,10); % Data choice from pushbutton SEASONS
yfit6 = polyval(p,Time);
yfitdiscretized6=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
nrows = 1;
ncols = (23/SampleTime)+1;
newyfitdiscretized6=yfitdiscretized6;
r=1;
for c = 1:ncols

    if  yfitdiscretized6(r,c)<0
        newyfitdiscretized6(r,c) = 0;
    else
newyfitdiscretized6(r,c)= yfitdiscretized6(r,c);
    end
end

  % Block E (Monsoon)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerEMonsoon,10); % Data choice from pushbutton SEASONS
yfit7 = polyval(p,Time);
yfitdiscretized7=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
nrows = 1;
ncols = (23/SampleTime)+1;
newyfitdiscretized7=yfitdiscretized7;
r=1;
for c = 1:ncols

    if  yfitdiscretized7(r,c)<0
        newyfitdiscretized7(r,c) = 0;
    else
newyfitdiscretized7(r,c)= yfitdiscretized7(r,c);
    end
end

% Block E (Intermediate)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerEIntermediate,10); % Data choice from pushbutton SEASONS
yfit8 = polyval(p,Time);
yfitdiscretized8=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
newyfitdiscretized8=yfitdiscretized8;
r=1;
for c = 1:ncols

    if  yfitdiscretized8(r,c)<0
        newyfitdiscretized8(r,c) = 0;
    else
newyfitdiscretized8(r,c)= yfitdiscretized8(r,c);
    end
end

% Block E (Winter)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerEWinter,10); % Data choice from pushbutton SEASONS
yfit9 = polyval(p,Time);
yfitdiscretized9=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
nrows = 1;
ncols = (23/SampleTime)+1;
newyfitdiscretized9=yfitdiscretized9;
r=1;
for c = 1:ncols

    if  yfitdiscretized9(r,c)<0
        newyfitdiscretized9(r,c) = 0;
    else
newyfitdiscretized9(r,c)= yfitdiscretized9(r,c);
    end
end

% Block C (Monsoon)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerCMonsoon,10); % Data choice from pushbutton SEASONS
yfit10 = polyval(p,Time);
yfitdiscretized10=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
nrows = 1;
ncols = (23/SampleTime)+1;
newyfitdiscretized10=yfitdiscretized10;
r=1;
for c = 1:ncols

    if  yfitdiscretized10(r,c)<0
        newyfitdiscretized10(r,c) = 0;
    else
newyfitdiscretized10(r,c)= yfitdiscretized10(r,c);
    end
end

% Block C (Intermediate)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerCIntermediate,10); % Data choice from pushbutton SEASONS
yfit11 = polyval(p,Time);
yfitdiscretized11=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
newyfitdiscretized11=yfitdiscretized11;
r=1;
for c = 1:ncols

    if  yfitdiscretized11(r,c)<0
        newyfitdiscretized11(r,c) = 0;
    else
newyfitdiscretized11(r,c)= yfitdiscretized11(r,c);
    end
end

% Block C (Winter)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerCWinter,10); % Data choice from pushbutton SEASONS
yfit12 = polyval(p,Time);
yfitdiscretized12=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
nrows = 1;
ncols = (23/SampleTime)+1;
newyfitdiscretized12=yfitdiscretized12;
r=1;
for c = 1:ncols

    if  yfitdiscretized12(r,c)<0
        newyfitdiscretized12(r,c) = 0;
    else
newyfitdiscretized12(r,c)= yfitdiscretized12(r,c);
    end
end


% Block A (Monsoon)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerAMonsoon,10); % Data choice from pushbutton SEASONS
yfit13 = polyval(p,Time);
yfitdiscretized13=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
nrows = 1;
ncols = (23/SampleTime)+1;
newyfitdiscretized13=yfitdiscretized13;
r=1;
for c = 1:ncols

    if  yfitdiscretized13(r,c)<0
        newyfitdiscretized13(r,c) = 0;
    else
newyfitdiscretized13(r,c)= yfitdiscretized13(r,c);
    end
end 

% Block A (Intermediate)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerAIntermediate,10); % Data choice from pushbutton SEASONS
yfit14 = polyval(p,Time);
yfitdiscretized14=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
newyfitdiscretized14=yfitdiscretized14;
r=1;
for c = 1:ncols

    if  yfitdiscretized14(r,c)<0
        newyfitdiscretized14(r,c) = 0;
    else
newyfitdiscretized14(r,c)= yfitdiscretized14(r,c);
    end
end

% Block A (Winter)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerAWinter,10); % Data choice from pushbutton SEASONS
yfit15 = polyval(p,Time);
yfitdiscretized15=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
nrows = 1;
ncols = (23/SampleTime)+1;
newyfitdiscretized15=yfitdiscretized15;
r=1;
for c = 1:ncols

    if  yfitdiscretized15(r,c)<0
        newyfitdiscretized15(r,c) = 0;
    else
newyfitdiscretized15(r,c)= yfitdiscretized15(r,c);
    end
end

% Block B (Monsoon)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerBMonsoon,10); % Data choice from pushbutton SEASONS
yfit16 = polyval(p,Time);
yfitdiscretized16=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
nrows = 1;
ncols = (23/SampleTime)+1;
newyfitdiscretized16=yfitdiscretized16;
r=1;
for c = 1:ncols

    if  yfitdiscretized16(r,c)<0
        newyfitdiscretized16(r,c) = 0;
    else
newyfitdiscretized16(r,c)= yfitdiscretized16(r,c);
    end
end

% Block B (Intermediate)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerBIntermediate,10); % Data choice from pushbutton SEASONS
yfit17 = polyval(p,Time);
yfitdiscretized17=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
newyfitdiscretized17=yfitdiscretized17;
r=1;
for c = 1:ncols

    if  yfitdiscretized17(r,c)<0
        newyfitdiscretized17(r,c) = 0;
    else
newyfitdiscretized17(r,c)= yfitdiscretized17(r,c);
    end
end   

% Block B (Winter)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerBWinter,10); % Data choice from pushbutton SEASONS
yfit18 = polyval(p,Time);
yfitdiscretized18=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
nrows = 1;
ncols = (23/SampleTime)+1;
newyfitdiscretized18=yfitdiscretized18;
r=1;
for c = 1:ncols

    if  yfitdiscretized18(r,c)<0
        newyfitdiscretized18(r,c) = 0;
    else
newyfitdiscretized18(r,c)= yfitdiscretized18(r,c);
    end
end

% Block LH (Monsoon)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerLHMonsoon,10); % Data choice from pushbutton SEASONS
yfit19 = polyval(p,Time);
yfitdiscretized19=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
nrows = 1;
ncols = (23/SampleTime)+1;
newyfitdiscretized19=yfitdiscretized19;
r=1;
for c = 1:ncols

    if  yfitdiscretized19(r,c)<0
        newyfitdiscretized19(r,c) = 0;
    else
newyfitdiscretized19(r,c)= yfitdiscretized19(r,c);
    end
end

% Block LH (Intermediate)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerLHIntermediate,10); % Data choice from pushbutton SEASONS
yfit20 = polyval(p,Time);
yfitdiscretized20=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
newyfitdiscretized20=yfitdiscretized20;
r=1;
for c = 1:ncols

    if  yfitdiscretized20(r,c)<0
        newyfitdiscretized20(r,c) = 0;
    else
newyfitdiscretized20(r,c)= yfitdiscretized20(r,c);
    end
end

% Block LH (Winter)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerLHWinter,10); % Data choice from pushbutton SEASONS
yfit21 = polyval(p,Time);
yfitdiscretized21=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
nrows = 1;
ncols = (23/SampleTime)+1;
newyfitdiscretized21=yfitdiscretized21;
r=1;
for c = 1:ncols

    if  yfitdiscretized21(r,c)<0
        newyfitdiscretized21(r,c) = 0;
    else
newyfitdiscretized21(r,c)= yfitdiscretized21(r,c);
    end
end

% Block RH (Monsoon)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerRHMonsoon,10); % Data choice from pushbutton SEASONS
yfit22 = polyval(p,Time);
yfitdiscretized22=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
nrows = 1;
ncols = (23/SampleTime)+1;
newyfitdiscretized22=yfitdiscretized22;
r=1;
for c = 1:ncols

    if  yfitdiscretized22(r,c)<0
        newyfitdiscretized22(r,c) = 0;
    else
newyfitdiscretized22(r,c)= yfitdiscretized22(r,c);
    end
end

% Block RH (Intermediate)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerRHIntermediate,10); % Data choice from pushbutton SEASONS
yfit23 = polyval(p,Time);
yfitdiscretized23=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
newyfitdiscretized23=yfitdiscretized23;
r=1;
for c = 1:ncols

    if  yfitdiscretized23(r,c)<0
        newyfitdiscretized23(r,c) = 0;
    else
newyfitdiscretized23(r,c)= yfitdiscretized23(r,c);
    end
end

% Block RH (Winter)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = polyfit(Time,customerRHWinter,10); % Data choice from pushbutton SEASONS
yfit24 = polyval(p,Time);
yfitdiscretized24=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
nrows = 1;
ncols = (23/SampleTime)+1;
newyfitdiscretized24=yfitdiscretized24;
r=1;
for c = 1:ncols

    if  yfitdiscretized24(r,c)<0
        newyfitdiscretized24(r,c) = 0;
    else
newyfitdiscretized24(r,c)= yfitdiscretized24(r,c);
    end
end

% Temperature for each seasons from the edit box

Temp1=zeros(1,(23/SampleTime)+1);% Creation matrix Temp1
Temp1(:,:)=26.8; % Set value into the matrix

Temp2=zeros(1,(23/SampleTime)+1);% Creation matrix Temp2
Temp2(:,:)=17.4; % Set value into the matrix

Temp3=zeros(1,(23/SampleTime)+1);% Creation matrix Temp3
Temp3(:,:)=23.4; % Set value into the matrix

% Intit file clocktxt
clock=0;
fid = fopen('clocktxt.txt','w');
fprintf(fid,' %i\n',clock);
fclose(fid)

fid0 = fopen('clocktxt2.txt','w');
fprintf(fid0,' %i\n',clock);
fclose(fid0)

% % Intit file txtvoltage
% voltage=0;
% fid1 = fopen('voltagetxt.txt','w');
% fprintf(fid1,' %i\n',voltage);
% fclose(fid1)

% Intit file txtfrequency
frequency=0;
fid2 = fopen('frequencytxt.txt','w');
fprintf(fid2,' %i\n',frequency);
fclose(fid2)

% Intit file txtsoc
SOC=0;
fid3 = fopen('soctxt.txt','w');
fprintf(fid3,' %i\n',SOC);
fclose(fid3)

% % Intit file txtcurrent
% current=0;
% fid4 = fopen('currenttxt.txt','w');
% fprintf(fid4,' %i\n',current);
% fclose(fid4)
% 
% % Intit file txtactivepower
% activepower=0;
% fid5 = fopen('activepowertxt.txt','w');
% fprintf(fid5,' %i\n',activepower);
% fclose(fid5)
% 
% % Intit file txtreactivepower
% reactivepower=0;
% fid6 = fopen('reactivepowertxt.txt','w');
% fprintf(fid6,' %i\n',reactivepower);
% fclose(fid6)

% Run the GUI
run('Supervision'); 
