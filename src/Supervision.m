
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The GUI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout =Supervision(varargin)

% Simulink model
modelName = 'Microgrid_24h_Simulation';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read the parameters from the workspace %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Execute MATLAB expression in specified workspace(Allow visibility for the GUI)
Ins_M=evalin('caller','Ins_Monsoon');         
Ins_I=evalin('caller',' Ins_Intermediate');   
Ins_W=evalin('caller','Ins_Winter'); 
Temp1=evalin('caller','Temp1');
Temp2=evalin('caller','Temp2');
Temp3=evalin('caller','Temp3');
xdiscretized=evalin('caller','xdiscretized'); 
ActivePower_dataALLMonsoon=evalin('caller','newyfitdiscretized1');
ActivePower_dataALLIntermediate=evalin('caller','newyfitdiscretized2');
ActivePower_dataALLWinter=evalin('caller','newyfitdiscretized3');
ActivePower_dataDMonsoon=evalin('caller','newyfitdiscretized4');
ActivePower_dataDIntermediate=evalin('caller','newyfitdiscretized5');
ActivePower_dataDWinter=evalin('caller','newyfitdiscretized6');
ActivePower_dataEMonsoon=evalin('caller','newyfitdiscretized7');
ActivePower_dataEIntermediate=evalin('caller','newyfitdiscretized8');
ActivePower_dataEWinter=evalin('caller','newyfitdiscretized9');
ActivePower_dataCMonsoon=evalin('caller','newyfitdiscretized10');
ActivePower_dataCIntermediate=evalin('caller','newyfitdiscretized11');
ActivePower_dataCWinter=evalin('caller','newyfitdiscretized12');
ActivePower_dataAMonsoon=evalin('caller','newyfitdiscretized13');
ActivePower_dataAIntermediate=evalin('caller','newyfitdiscretized14');
ActivePower_dataAWinter=evalin('caller','newyfitdiscretized15');
ActivePower_dataBMonsoon=evalin('caller','newyfitdiscretized16');
ActivePower_dataBIntermediate=evalin('caller','newyfitdiscretized17');
ActivePower_dataBWinter=evalin('caller','newyfitdiscretized18');
ActivePower_dataLHMonsoon=evalin('caller','newyfitdiscretized19');
ActivePower_dataLHIntermediate=evalin('caller','newyfitdiscretized20');
ActivePower_dataLHWinter=evalin('caller','newyfitdiscretized21');
ActivePower_dataRHMonsoon=evalin('caller','newyfitdiscretized22');
ActivePower_dataRHIntermediate=evalin('caller','newyfitdiscretized23');
ActivePower_dataRHWinter=evalin('caller','newyfitdiscretized24');
jpg=evalin('caller','jpg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create the user interface %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  Create and then hide the GUI as it is being constructed.
f = figure('Visible','off','Position',[360,500,450,285],'MenuBar','None');

% Change the name of the window
set(f,'Name','Design of a Solar Microgrid','NumberTitle','off')

% Construct the components %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add "Monsoon" button to window
hmonsoon = uicontrol('Style','pushbutton','String','Monsoon',...
  'Parent', f, ...
  'Position',[15,250,30,10],...
  'Callback',{@monsoonbutton_Callback});

% Add "Intermediate" button to window
hintermediate = uicontrol('Style','pushbutton','String','Intermediate',...
  'Parent', f, ...
  'Position',[15,235,30,10],...
  'Callback',{@intermediatebutton_Callback});

% Add "Winter" button to window
hwinter = uicontrol('Style','pushbutton',...
  'Parent', f, ...
  'String','Winter',...
  'Position',[15,220,30,10],...
  'Callback',{@winterbutton_Callback}); 

% Add "Run" button to window
hrun = uicontrol('Style','pushbutton',...
  'Parent', f, ...
  'String','Run',...
  'Tag','run',...
  'Enable','on',...
  'Position',[15,100,30,10],...
  'Callback',{@runbutton_Callback}); 

% Add "Stop" button to window
hstop = uicontrol('Style','pushbutton',...
  'Parent', f, ...
  'String','Stop',...
  'Tag','stop',...
  'Position',[15,85,30,10],...
  'Enable','off',...
  'Callback',{@stopbutton_Callback}); 

% Add "Update" button to window
hupdate = uicontrol('Style','pushbutton',...
  'Parent', f, ...
  'String','Update',...
  'Tag','update',...
  'Position',[15,115,30,8],...
  'Enable','off',...
  'Callback',{@updatebutton_Callback}); 

% Add "Temperature outside = °C" text to window
htext1 = uicontrol('Style','text','String','Temperature outside = °C',...
  'Position',[15,205,50,5]);

% Add "SUPERVISION" text to window
htext2 = uicontrol('Style','text','String','SUPERVISION',...
  'Position',[0,275,450,10],'FontSize', 16); 

% Add "Temperature pannel =  °C" text to window
htext3 = uicontrol('Style','text','String','Temperature pannel =  °C',...
  'Position',[15,195,50,5]); 

% Add Vertical ligne to window
htext4 = uicontrol('Style','text','String','',...
  'Position',[90,0,1,185]);

% Add Vertical ligne to window
htext5 = uicontrol('Style','text','String','',...
  'Position',[210,0,1,275]); 

% Add Horizontal ligne to window
htext7 = uicontrol('Style','text','String','',...
  'Position',[0,185,210,1]);

% Add "ESTIMATED INSOLATION" to window
htext8 = uicontrol('Style','text','String','ESTIMATED INSOLATION',...
  'Position',[70,269,80,5]);

% Add "PARAMETERS" text to window
htextparameters = uicontrol('Style','text','String','PARAMETERS',...
  'Position',[5,179,80,5]);

% Add "LOAD PROFIL" text to window
htextpower = uicontrol('Style','text','String','LOAD PROFIL',...
  'Position',[112.5,179,80,5]);

% Add "STABILITY OF THE GRID" text to window
htextstability = uicontrol('Style','text','String','STABILITY OF THE GRID',...
  'Position',[290,269,80,5]); 

% Add text to window
htextboxpopup = uicontrol('Style','text','String','Choose the block according the season',...
  'Position',[15,135,70,5]);

% Add "'All Blocks','Block D','Block E','Block C', 'Block A','Block B','Block LH','Block RH" pop-up button to window
hpopup = uicontrol('Style','popupmenu',...
  'Parent', f, ...
  'String',{'All Blocks Monsoon','All Blocks Intermediate','All Blocks Winter','Block D Monsoon','Block D Intermediate','Block D Winter',...
  'Block E Monsoon','Block E Intermediate','Block E Winter','Block C Monsoon','Block C Intermediate','Block C Winter','Block A Monsoon','Block A Intermediate',...
  'Block A Winter','Block B Monsoon','Block B Intermediate','Block B Winter','Block LH Monsoon','Block LH Intermediate','Block LH Winter','Block RH Monsoon','Block RH Intermediate','Block RH Winter'},...
  'Position',[15,120,50,15],...
  'Enable','on',...
  'Callback',{@popup_menu_Callback});  

% Add "h1" axe to window (Insolation)
h1 = axes('Units','Pixels','Position',[107.5,200,95,60]);

% Add "h2" axe to window (Active power)
h2 = axes('Units','Pixels','Position',[107.5,110,95,60]); 

% Add "h3" axe to window (Reactive power)
h3 = axes('Units','Pixels','Position',[107.5,20,95,60]); 

% Add "h4" axe to window (Voltage)
h4 = axes('Parent', f, ...
    'Tag','h4',...
    'Units','Pixels','Position',[227.5,200,95,60],'Tag','newdata4');

% Add "h5" axe to window (Frequency)
h5 = axes('Parent', f, ...
    'Tag','h5',...
    'Units','Pixels','Position',[227.5,110,95,60],'Tag','newdata5');

% Add "h6" axe to window (State of charge SOC)
h6 = axes('Parent', f, ...
    'Tag','h6',...
    'Units','Pixels','Position',[227.5,20,95,60],'Tag','newdata6');

% Add "h8" axe to window (State of charge SOC)
h8 = axes('Parent', f, ...
    'Tag','h8',...
    'Units','Pixels','Position',[350,200,95,60],'Tag','newdata8');

% Add "h9" axe to window (State of charge SOC)
h9 = axes('Parent', f, ...
    'Tag','h9',...
    'Units','Pixels','Position',[350,110,95,60],'Tag','newdata9');

% Add "h10" axe to window (State of charge SOC)
h10 = axes('Parent', f, ...
    'Tag','h10',...
    'Units','Pixels','Position',[350,20,95,60],'Tag','newdata10');

% Add text to window
htexttxtbox1 = uicontrol('Style','text','String','Enter the number of pannel',...
  'Position',[15,165,50,5]);
% Add Text box to window 
txtbox1 = uicontrol(f,'Style','edit',...
  'String','',...
  'Position',[15 160 15 5]);
% Add text to window
htexttxtbox2 = uicontrol('Style','text','String','Enter the number of battery',...
  'Position',[15,150,50,5]);
% Add Text box to window
txtbox2 = uicontrol(f,'Style','edit',...
   'String','',...
   'Position',[15 145 15 5]);

% Add "h7" axe to window (Picture)
h7 = axes('Units','Pixels','Position',[10,10,70,70]); 

% Initialize the GUI %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add picture to window 
imshow(jpg);
title('Bhutan Project');

% Align elements in parameters 
align([hmonsoon,hintermediate,hwinter,hstop,htextboxpopup,hrun,htexttxtbox1,htexttxtbox2,htext1,hupdate,htext3,txtbox1,txtbox2,htextparameters,h7,hpopup],'Center','None');

% Color 
set(hrun,'BackgroundColor', [0.396 1 0.558]);
set(hstop,'BackgroundColor', [1 0.286 0.145]);

% Change units to normalized so components resize automatically.
set([f,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,hmonsoon,hintermediate,htextboxpopup,htexttxtbox1,htexttxtbox2,hwinter,hstop,hrun,txtbox1,txtbox2,hupdate,htext1,htext8,htext2,htext3,htext7,htext4,htext5,htextparameters,htextstability,htextpower,hpopup],...
'Units','normalized');

% Full screen
set(f, 'Units', 'Normalized', 'Position', [0 0 1 1]);

% Initialize a plot in the axes
SampleTime=0.1;
xdiscretized=1:SampleTime:24;

% Initialize the plot h1 with Ins_Monsoon from DataBase.m
plot(h1,xdiscretized,Ins_M,'m'); 
xlabel(h1,'Time (Hours)');
ylabel(h1,'Insolation (W/m²)');
title(h1,'Insolation during the Monsoon');
grid(h1,'on');
set(htext1, 'String', 'Temperature outside = 26.8°C');
set(htext3, 'String', 'Temperature pannel = 46°C');
% Vector Data for the Simulink (Insolation)
VARins = [xdiscretized;Ins_M];
% Vector Data for the Simulink (Temperature)
VARTemp = [xdiscretized;Temp1];
% Vector Data for the Simulink (Power)
VARPA= [xdiscretized;ActivePower_dataALLMonsoon];
VARPQ= [xdiscretized;ActivePower_dataALLMonsoon/10];
% Write Data vectors in the workspace for the Simulink 
assignin('base', 'VARins', VARins);
assignin('base', 'VARTemp', VARTemp);
assignin('base', 'VARPA', VARPA);
assignin('base', 'VARPQ', VARPQ);

% Initialize variable clock generate by the simulink mandatory for the use of linkdata
clock=0;
assignin('base','clock', clock);
superclock=[clock;clock;clock];
assignin('base', 'superclock', superclock);

% Initialize axes h4
V=[0;0;0];
assignin('base','V', V);
H4=plot(h4,superclock,V,'ro');
set(H4,'XDataSource','superclock')
set(H4,'YDataSource','V')
xlabel(h4,'Time (Hours)');
ylabel(h4,'Load Voltage (V)');
title(h4,'Voltage Grid');
grid(h4,'on');

%Initialize axes h5
F=0;
assignin('base', 'F', F);
% load('Data1.mat');
% load('Data2.mat');
% frequency=load('Data2.mat')
% assignin('base', 'ff', load('Data2.mat'));
% ff=evalin('caller','ff');
% assignin('base', 'FF', ff');
% F=load('Data2.mat');
% evalin('caller','T');
% F=evalin('caller','F');
% plot(h5,frequency.times,frequency.counts,':b');
% plot(h5,F.time,F.signals.values,':b')
% H5=plot(h5,frequency.F,':b');
H5=plot(h5,clock,F,'ro');
set(H5,'XDataSource','clock')
set(H5,'YDataSource','F')
xlabel(h5,'Time (Hours)');
ylabel(h5,'f (Hz)');
title(h5,'Frequency');
grid(h5,'on');

% Initialize axes h6
SOC=0;
assignin('base','SOC', SOC);
H6=plot(h6,clock,SOC,'ro');
set(H6,'XDataSource','clock')
set(H6,'YDataSource','SOC')
xlabel(h6,'Time (Hours)');
ylabel(h6,'SOC (%)');
title(h6,'State of charge');
grid(h6,'on');

% Initialize axes h8
xlabel(h8,'Time (Hours)');
ylabel(h8,'Current (A)');
title(h8,'Load Current');
grid(h8,'on');

% Initialize axes h9
xlabel(h9,'Time (Hours)');
ylabel(h9,'Active Power (W)');
title(h9,'Load Active Power');
grid(h9,'on');

% Initialize axes h10
xlabel(h10,'Time (Hours)');
ylabel(h10,'Reactive Power (kVAR)');
title(h10,'Load Reactive Power');
grid(h10,'on');

% Initialize plot h2 for the Active power with dataBase/PowerAllMonsoon.mat
plot(h2,xdiscretized,ActivePower_dataALLMonsoon);
xlabel(h2,'Time (Hours)');
ylabel(h2,'Active Power (kW)');
title(h2,'Active Power All Blocks during Monsoon');

% Initialize plote h3 for the Reactive power (In our case we make an assumption, it is just the Active power divided by 10).
plot(h3,xdiscretized,ActivePower_dataALLMonsoon/10,'r');
xlabel(h3,'Time (Hours)');
ylabel(h3,'Reactive Power (kVAR)');
title(h3,'Reactive Power All Blocks during Monsoon')

% Initialize grid 
grid(h2,'on');
grid(h3,'on');
grid(h4,'on');
grid(h5,'on');
grid(h6,'on');

% Move the GUI to the center of the screen.
movegui(f,'center');

% Make the GUI visible.
set(f,'Visible','on');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Callback Function for the popup menu %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function popup_menu_Callback(source, eventdata, handles)

 % Determine the selected data set.
 str = get(source, 'String');
 val = get(source,'Value');

 % Set current data to the selected data set.
 switch str{val};           

 % User selects All Blocks %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 case 'All Blocks Monsoon'  
 plot(h2,xdiscretized,ActivePower_dataALLMonsoon);
 title(h2,'Active Power All Blocks during the Monsoon');
 xlabel(h2,'Time (Hours)');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataALLMonsoon/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power All Blocks during the Monsoon')
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_M];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp1];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataALLMonsoon];
 VARPQ= [xdiscretized;ActivePower_dataALLMonsoon/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'All Blocks Intermediate'  
 plot(h2,xdiscretized,ActivePower_dataALLIntermediate);
 title(h2,'Active Power All Blocks during the Intermediate Season');
 xlabel(h2,'Time (Hours)');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataALLIntermediate/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power All Blocks during the Intermediate Season')
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_I];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp2];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataALLIntermediate];
 VARPQ= [xdiscretized;ActivePower_dataALLIntermediate/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'All Blocks Winter'  
 plot(h2,xdiscretized,ActivePower_dataALLWinter);
 title(h2,'Active Power All Blocks during the Winter');
 xlabel(h2,'Time (Hours)');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataALLWinter/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power All Blocks during the Winter')
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_W];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp3];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataALLWinter];
 VARPQ= [xdiscretized;ActivePower_dataALLWinter/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 % User selects Block D %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 case 'Block D Monsoon' 
 plot(h2,xdiscretized,ActivePower_dataDMonsoon);
 title(h2,'Active Power Block D during the Monsoon');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataDMonsoon/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block D during the Monsoon');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_M];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp1];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataDMonsoon];
 VARPQ= [xdiscretized;ActivePower_dataDMonsoon/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block D Intermediate' 
 plot(h2,xdiscretized,ActivePower_dataDIntermediate);
 title(h2,'Active Power Block D during the Intermediate Season');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataDIntermediate/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block D during the Intermediate Season');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_I];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp2];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataDIntermediate];
 VARPQ= [xdiscretized;ActivePower_dataDIntermediate/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block D Winter' 
 plot(h2,xdiscretized,ActivePower_dataDWinter);
 title(h2,'Active Power Block D during the Winter');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataDWinter/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block D during the Winter');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_W];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp3];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataDWinter];
 VARPQ= [xdiscretized;ActivePower_dataDWinter/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 % User selects Block E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 case 'Block E Monsoon' 
 plot(h2,xdiscretized,ActivePower_dataEMonsoon);
 title(h2,'Active Power Block E during the Monsoon');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataEMonsoon/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block E during the Monsoon');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_M];
 % Vector Data for the Simulink (Temperature)
 VARTemp= [xdiscretized;Temp1];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataEMonsoon];
 VARPQ= [xdiscretized;ActivePower_dataEMonsoon/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block E Intermediate' 
 plot(h2,xdiscretized,ActivePower_dataEIntermediate);
 title(h2,'Active Power Block E during the Intermediate Season');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataEIntermediate/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block E during the Intermediate Season')
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_I];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp2];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataEIntermediate];
 VARPQ= [xdiscretized;ActivePower_dataEIntermediate/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block E Winter' 
 plot(h2,xdiscretized,ActivePower_dataEWinter);
 title(h2,'Active Power Block E during the Winter');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataEWinter/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block E during the Winter');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_W];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp3];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataEWinter];
 VARPQ= [xdiscretized;ActivePower_dataEWinter/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 % User selects Block C %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 case 'Block C Monsoon' 
 plot(h2,xdiscretized,ActivePower_dataCMonsoon);
 title(h2,'Active Power Block C during the Monsoon');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataCMonsoon/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block C during the Monsoon');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_M];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp1];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataCMonsoon];
 VARPQ= [xdiscretized;ActivePower_dataCMonsoon/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block C Intermediate' 
 plot(h2,xdiscretized,ActivePower_dataCIntermediate);
 title(h2,'Active Power Block C during the Intermediate Season');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataCIntermediate/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block C during the Intermediate Season');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_I];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp2];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataCIntermediate];
 VARPQ= [xdiscretized;ActivePower_dataCIntermediate/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block C Winter' 
 plot(h2,xdiscretized,ActivePower_dataCWinter);
 title(h2,'Active Power Block C during the Winter');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataCWinter/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block C during the Winter');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_W];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp3];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataCWinter];
 VARPQ= [xdiscretized;ActivePower_dataCWinter/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 % User selects Block A %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 case 'Block A Monsoon' 
 plot(h2,xdiscretized,ActivePower_dataAMonsoon);
 title(h2,'Active Power Block A during the Monsoon');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataAMonsoon/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block A during the Monsoon');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_M];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp1];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataAMonsoon];
 VARPQ= [xdiscretized;ActivePower_dataAMonsoon/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block A Intermediate' 
 plot(h2,xdiscretized,ActivePower_dataAIntermediate);
 title(h2,'Active Power Block A during the Intermediate Season');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataAIntermediate/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block A during the Intermediate Season');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_I];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp2];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataAIntermediate];
 VARPQ= [xdiscretized;ActivePower_dataAIntermediate/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block A Winter' 
 plot(h2,xdiscretized,ActivePower_dataAWinter);
 title(h2,'Active Power Block A during the Winter');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataAWinter/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block A during the Winter');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_W];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp3];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataAWinter];
 VARPQ= [xdiscretized;ActivePower_dataAWinter/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 % User selects Block B %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 case 'Block B Monsoon' 
 plot(h2,xdiscretized,ActivePower_dataBMonsoon);
 title(h2,'Active Power Block B during the Monsoon');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataBMonsoon/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block B during the Monsoon');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_M];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp1];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataBMonsoon];
 VARPQ= [xdiscretized;ActivePower_dataBMonsoon/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block B Intermediate' 
 plot(h2,xdiscretized,ActivePower_dataBIntermediate);
 title(h2,'Active Power Block B during the Intermediate Season');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataBIntermediate/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block B during the Intermediate Season');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_I];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp2];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataBIntermediate];
 VARPQ= [xdiscretized;ActivePower_dataBIntermediate/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block B Winter'
 plot(h2,xdiscretized,ActivePower_dataBWinter);
 title(h2,'Active Power Block B during the Winter');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataBWinter/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block B during the Winter');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_W];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp3];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataBWinter];
 VARPQ= [xdiscretized;ActivePower_dataBWinter/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 % User selects Block LH %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 case 'Block LH Monsoon' 
 plot(h2,xdiscretized,ActivePower_dataLHMonsoon);
 title(h2,'Active Power Block LH during the Monsoon');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataLHMonsoon/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block LH during the Monsoon');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_M];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp1];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataLHMonsoon];
 VARPQ= [xdiscretized;ActivePower_dataLHMonsoon/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block LH Intermediate' 
 plot(h2,xdiscretized,ActivePower_dataLHIntermediate);
 title(h2,'Active Power Block LH during the Intermediate Season');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataLHIntermediate/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block LH during the Intermediate Season');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_I];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp2];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataLHIntermediate];
 VARPQ= [xdiscretized;ActivePower_dataLHIntermediate/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block LH Winter' 
 plot(h2,xdiscretized,ActivePower_dataLHWinter);
 title(h2,'Active Power Block LH during the Winter');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataLHWinter/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block LH during the Winter');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_W];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp3];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataLHWinter];
 VARPQ= [xdiscretized;ActivePower_dataLHWinter/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 % User selects Block RH %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 case 'Block RH Monsoon'
 plot(h2,xdiscretized,ActivePower_dataRHMonsoon);
 title(h2,'Active Power Block RH during the Monsoon');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataRHMonsoon/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block RH during the Monsoon');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_M];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp1];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataRHMonsoon];
 VARPQ= [xdiscretized;ActivePower_dataRHMonsoon/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block RH Intermediate'
 plot(h2,xdiscretized,ActivePower_dataRHIntermediate);
 title(h2,'Active Power Block RH during the Intermediate Season');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
  plot(h3,xdiscretized,ActivePower_dataRHIntermediate/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block RH during the Intermediate Season');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_I];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp2];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataRHIntermediate];
 VARPQ= [xdiscretized;ActivePower_dataRHIntermediate/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);

 case 'Block RH Winter'
 plot(h2,xdiscretized,ActivePower_dataRHWinter);
 title(h2,'Active Power Block RH during the Winter');
 ylabel(h2,'Active Power (kW)');
 grid(h2,'on');
 plot(h3,xdiscretized,ActivePower_dataRHWinter/10,'r');
 xlabel(h3,'Time (Hours)');
 ylabel(h3,'Reactive Power (kVAR)');
 title(h3,'Reactive Power Block RH during the Winter');
 grid(h3,'on');
 % Vector Data for the Simulink (Insolation)
 VARins = [xdiscretized;Ins_W];
 % Vector Data for the Simulink (Temperature)
 VARTemp = [xdiscretized;Temp3];
 % Vector Data for the Simulink (Power)
 VARPA= [xdiscretized;ActivePower_dataRHWinter];
 VARPQ= [xdiscretized;ActivePower_dataRHWinter/10];
 % Write Data vectors in the workspace for the Simulink 
 assignin('base', 'VARins', VARins);
 assignin('base', 'VARTemp', VARTemp);
 assignin('base', 'VARPA', VARPA);
 assignin('base', 'VARPQ', VARPQ);
 end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Callback Function for the monsoon button %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function monsoonbutton_Callback(source, eventdata, handles) 

% Plot monsoon season from dataBase
plot(h1,xdiscretized,Ins_M,'r'); 
xlabel(h1,'Time (Hours)');
ylabel(h1,'Insolation (W/m²)');
title(h1,'Insolation during the Monsoon');
grid(h1,'on');
set(htext1, 'String', 'Temperature outside = 26.8°C');
set(htext3, 'String', 'Temperature pannel = 46°C');
% Turn off the monsoon button
set(hmonsoon,'Enable','off');
set(hintermediate,'Enable','on');
set(hwinter,'Enable','on');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Callback Function for the intermediate button %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function intermediatebutton_Callback(source, eventdata, handles) 

% Plot intemediate season from dataBase
plot(h1,xdiscretized,Ins_I,'m');
xlabel(h1,'Time (Hours)');
ylabel(h1,'Insolation (W/m²)');
title(h1,'Insolation during the Intermediate Season');
grid(h1,'on');
set(htext1, 'String', 'Temperature outside = 17.4°C');
set(htext3, 'String', 'Temperature pannel = 46°C');

% Turn off the intermediate button
set(hmonsoon,'Enable','on');
set(hintermediate,'Enable','off');
set(hwinter,'Enable','on');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Callback Function for the winter button %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function winterbutton_Callback(source, eventdata, handles) 

% Plot winter season from dataBase
plot(h1,xdiscretized,Ins_W,'g');
xlabel(h1,'Time (Hours)');
ylabel(h1,'Insolation (W/m²)');
title(h1,'Insolation during the Winter');
grid(h1,'on');
set(htext1, 'String', 'Temperature outside = 23.4°C');
set(htext3, 'String', 'Temperature pannel = 46°C');

% Turn off the winter button
set(hmonsoon,'Enable','on');
set(hintermediate,'Enable','on');
set(hwinter,'Enable','off');

end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Callback Function for the run button %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function runbutton_Callback(source, eventdata, handles)
      
message1 = msgbox('Please wait ! This simulation will take few hours');

% toggle the buttons %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Turn off the Start button
set(hrun,'Enable','off');
% Turn on the Stop button
set(hstop,'Enable','on');
% Turn off the popup menu
set(hpopup,'Enable','off');
% Turn on the update button
set(hupdate,'Enable','on');
% Turn off  
set(txtbox2,'Enable','off');
set(txtbox1,'Enable','off');

% update the model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% set_param(modelName,'SimulationCommand','update');

% start the model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set_param(modelName,'SimulationCommand','start');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Callback Function for the stop button %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function stopbutton_Callback(source, eventdata, handles) 
    
% toggle the buttons %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Turn on the Start button
set(hrun,'Enable','on');
% Turn off the Stop button
set(hstop,'Enable','off');
% Turn on the popup menu
set(hpopup,'Enable','on');
% Turn off the update button
set(hupdate,'Enable','off');
% Turn on 
set(txtbox2,'Enable','on');
set(txtbox1,'Enable','on');

% stop the model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set_param(modelName,'SimulationCommand','stop');

end

function updatebutton_Callback(source, eventdata, handles) 
   
end

end


function varargout = updategui(varargin)
    
% Take the data from the simulink %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Time
rtoc = get_param('Microgrid_24h_Simulation/Subsystem/Clock','RuntimeObject');
clock= rtoc.OutputPort(1).Data;
superclock=[clock;clock;clock];
assignin('base', 'clock', clock);
assignin('base', 'superclock', superclock);

 
% SOC
rto1 = get_param('Microgrid_24h_Simulation/Subsystem/Gain1','RuntimeObject');
SOC= rto1.OutputPort(1).Data;
assignin('base', 'SOC', SOC);
save SOCfile SOC;
 
% Execute MATLAB expression in specified workspace(Allow visibility for the workspace)
 
% Take the data from the simulink %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Frequency
rto2 = get_param('Microgrid_24h_Simulation/Subsystem/Gain2','RuntimeObject');
F= rto2.OutputPort(1).Data;
assignin('base','F', F);


% Take the data from the simulink %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Voltage
rto3 = get_param('Microgrid_24h_Simulation/Subsystem/Gain3','RuntimeObject');
V= rto3.OutputPort(1).Data;
assignin('base','V', V);

% assignin('base', 'ff', load('Data2.mat'));
% load('Data1.mat');
% load('Data2.mat');


% Updating Graphs with refreshdata
refreshdata

end



