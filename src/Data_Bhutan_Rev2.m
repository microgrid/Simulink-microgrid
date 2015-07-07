

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SIMULATION INSULATION PER SEASONS AND LOAD BLOCK D%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% modify sample time for the daily representation
% modify data from excel for each seasons and load 
% modify  Q according P
% modify Number of pannels in futur script

 

%%  Raw Data power%%
%%%%%%%%%%%%%%%%%%%%
customer=importdata('dataBase\PowerEMonsoon.mat'); % Power2.mat Data from excel
sample=importdata('dataBase\SampleT.mat');  % SampleT.mat Data from excel
linewidth=2;
x=sample;

%Raw Data Load Representation
% figure
% plot(customer,'r','LineWidth',linewidth)
% xlabel('Hours', 'FontSize', 20)
% ylabel('Power', 'FontSize', 20)
% grid on
% legend('Daily consumption')

%%  Data Insolation 1 Monsoon%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
ins1=importdata('dataBase\Insolation1.mat');

% Normal law insolation Monsoon
SampleTime=0.1;
xins1 = 1:SampleTime:24;
% xins1 Distribution value
% 12 Distribution Average
% 1.7 The standard deviation of the distribution
norm1 = normpdf(xins1,12,1.7)*3990; % 3990  Average Insolation Incident On A Horizontal Surface (kWh/m^2/Season)

% Insulation Representation
% figure;
% plot(xins1,norm1)
% xlabel('Hours', 'r', 20)
% ylabel('Power', 'r', 20)
% grid on
% legend('Insolation Monsoon')

% Data Link for Simulink Insulation Monsoon
VARins1 = [xins1;norm1];

% figure
% plot(ins1,'g','LineWidth',linewidth)
% xlabel('Hours', 'FontSize', 20)
% ylabel('Power', 'FontSize', 20)
% grid on
% legend('Insolation Monsoon')

%%  Data Insolation 2 Intermediate Season%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ins2=importdata('dataBase\Insolation2.mat');

% Normal law Intermediate Season
SampleTime=0.1;
xins2 = 1:SampleTime:24;
norm2 = normpdf(xins2,12,1.7)*4583; % 4583  Average Insolation Incident On A Horizontal Surface (kWh/m^2/Season)

% Insulation Representation
% figure
% plot(xins2,norm2)
% xlabel('Hours', 'FontSize', 20)
% ylabel('Power', 'FontSize', 20)
% grid on
% legend('Insolation Intermediate Season')

% Data Link for Simulink Insulation Intermediate Season
VARins2 = [xins2;norm2];

% figure
% plot(ins2,'y','LineWidth',linewidth)
% xlabel('Hours', 'FontSize', 20)
% ylabel('Power', 'FontSize', 20)
% grid on
% legend('Insolation Intermediate Season')

%%  Data Insolation 3 Winter %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ins3=importdata('dataBase\Insolation3.mat');

% Normal law insolation Winter
SampleTime=0.1;
xins3 = 1:SampleTime:24;
norm3 = normpdf(xins3,12,1.7)*4888; % 4888  Average Insolation Incident On A Horizontal Surface (kWh/m^2/Season)

% Insulation Representation
% figure
% plot(xins3,norm3)
% xlabel('Hours', 'FontSize', 20)
% ylabel('Power', 'FontSize', 20)
% grid on
% legend('Insolation Winter')

% Data Link for Simulink Insulation Winter
VARins3 = [xins3;norm3];

% figure
% plot(ins3,'m','LineWidth',linewidth)
% xlabel('Hours', 'FontSize', 20)
% ylabel('Power', 'FontSize', 20)
% grid on
% legend('Insolation Winter')

%% linear regression with a polynomial approach for the load%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x=sample;
y=customer;
p = polyfit(x,y,10);
yfit = polyval(p,x);
SampleTime=0.1;
xcontinous=1:SampleTime:24;
yfitcontinous=polyval(p,xcontinous);

%Polynomial Representation of the final load with correction
% figure
% hold on
% plot(x,y,'s');
% plot(xcontinous,yfitcontinous, '--r', 'LineWidth',2);
% grid on
% % legend('Données','Modèle')
% xlabel('x')
% ylabel('y')
% hold off
%% Delete values below zero for the final curve%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nrows = 1;
ncols = (23/SampleTime)+1;
newyfit=yfitcontinous;
r=1;
    for c = 1:ncols

        if  yfitcontinous(r,c)<0
            newyfit(r,c) = 0;
        else
   newyfit(r,c)= yfitcontinous(r,c);
        end

    end
    
%Polynomial Representation of the load with correction (Active Power)
% figure
% hold on
% % plot(x,y,'s');
% plot(x,customer,'g')
% plot(xcontinous,newyfit, 'r', 'LineWidth',2);
% xlabel('Hours', 'FontSize', 20)
% ylabel('Active Power (W)', 'FontSize', 20)
% grid on
% legend('Raw Active Power')
% legend('Active Power')


% Reactive Power
ReacPow=10; % % of Reactive Power

% Polynomial Representation of the load with correction (Reactive Power)
% figure
% hold on
% plot(xcontinous,newyfit/ReacPow, 'm');
% xlabel('Hours', 'FontSize', 20)
% ylabel('Reactive Power (W)', 'FontSize', 20)
% grid on


%% Data Link for Simulink Load P and Q%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

time=xcontinous;
data1=newyfit; 
data2=newyfit/100;

VAR1= [time;data1];
VAR2= [time;data2];

%% Delate values below zero first model without sampling%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nrows = 24;
ncols = 1;
newyfit2=yfit;
for c=1
    for r = 1:nrows

        if  yfit(r,c)<0
            newyfit2(r,c) = 0;
        else
   newyfit2(r,c)= yfit(r,c);
        end

    end
end

%% Pattern representation
% figure
% hold on
% plot(x,y,'s');
% plot(x,newyfit2, '--r', 'LineWidth',2);
% grid on
% % legend('Données','Modèle')
% xlabel('x')
% ylabel('y')
% hold off
% 
% 
% % Quality measure 
% residus = y - yfit;
% 
% % Quality Representation
% figure
% stem(residus)
% grid on
% legend('Résidus')
%% Temperature for each seasons%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xtemp = 1:SampleTime:24;
Temp1=zeros(1,(23/SampleTime)+1);% Creation matrix
Temp1(:,:)=26.8; % Set value into the matrix

Temp2=zeros(1,(23/SampleTime)+1);% Creation matrix
Temp2(:,:)=17.4; % Set value into the matrix

Temp3=zeros(1,(23/SampleTime)+1);% Creation matrix
Temp3(:,:)=23.4; % Set value into the matrix

% Temp1=importdata('Temp1.mat');
% Temp2=importdata('Temp2.mat');
% Temp3=importdata('Temp3.mat');

% Data Link for Simulink Temperature
VARTemp1 = [xtemp;Temp1];% Monsoon
VARTemp2 = [xtemp;Temp2];% Intermediate Season
VARTemp3 = [xtemp;Temp3];% Winter
    
% run('Supervision_Rev2'); Run GUI