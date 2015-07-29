% Block All (Monsoon)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
customerAllMonsoon=importdata('dataBase/PowerAllMonsoon.mat');
Time=importdata('dataBase/SampleT.mat');
figure
plot(Time,customerAllMonsoon);
SampleTime=5e-6;
xdiscretized=0.1:SampleTime:2.4;

p = polyfit(Time/10,customerAllMonsoon,10); % Data choice from pushbutton SEASONS
yfit1 = polyval(p,Time/10);
yfitdiscretized1=polyval(p,xdiscretized);

% Delete values below zero for the final curve for the Active power of the load
nrows = 1;
ncols = (2.3/SampleTime)+0.1;
newyfitdiscretized1=yfitdiscretized1;
r=1;
for c = 1:ncols

    if  yfitdiscretized1(r,c)<0
        newyfitdiscretized1(r,c) = 0;
    else
newyfitdiscretized1(r,c)= yfitdiscretized1(r,c);
    end
end

hold on
figure
plot(xdiscretized,newyfitdiscretized1)
% plot(Time,customerAllMonsoon)

Temp1=zeros(1,((2.3/SampleTime)+2));% Creation matrix Temp1
Temp1(:,:)=26.8; % Set value into the matrix
plot(xdiscretized,Temp1);
