function Supervision

 % Execute MATLAB expression in specified workspace(Allow visibility for the GUI)
Ins_M=evalin('caller','Ins_Monsoon');         
Ins_I=evalin('caller',' Ins_Intermediate');   
Ins_W=evalin('caller','Ins_Winter');          
xdiscretized=evalin('caller','xdiscretized'); 
ActivePower_dataALLMonsoon=evalin('caller','newyfitdiscretized');
ActivePower_dataALLIntermediate=evalin('caller','newyfitdiscretized');
ActivePower_dataALLWinter=evalin('caller','newyfitdiscretized');
ActivePower_dataDMonsoon=evalin('caller','newyfitdiscretized');
ActivePower_dataDIntermediate=evalin('caller','newyfitdiscretized');
ActivePower_dataDWinter=evalin('caller','newyfitdiscretized');
ActivePower_dataEMonsoon=evalin('caller','newyfitdiscretized');
ActivePower_dataEIntermediate=evalin('caller','newyfitdiscretized');
ActivePower_dataEWinter=evalin('caller','newyfitdiscretized');
ActivePower_dataCMonsoon=evalin('caller','newyfitdiscretized');
ActivePower_dataCIntermediate=evalin('caller','newyfitdiscretized');
ActivePower_dataCWinter=evalin('caller','newyfitdiscretized');
ActivePower_dataAMonsoon=evalin('caller','newyfitdiscretized');
ActivePower_dataAIntermediate=evalin('caller','newyfitdiscretized');
ActivePower_dataAWinter=evalin('caller','newyfitdiscretized');
ActivePower_dataBMonsoon=evalin('caller','newyfitdiscretized');
ActivePower_dataBIntermediate=evalin('caller','newyfitdiscretized');
ActivePower_dataBWinter=evalin('caller','newyfitdiscretized');
ActivePower_dataLHMonsoon=evalin('caller','newyfitdiscretized');
ActivePower_dataLHIntermediate=evalin('caller','newyfitdiscretized');
ActivePower_dataLHWinter=evalin('caller','newyfitdiscretized');
ActivePower_dataRHMonsoon=evalin('caller','newyfitdiscretized');
ActivePower_dataRHIntermediate=evalin('caller','newyfitdiscretized');
ActivePower_dataRHWinter=evalin('caller','newyfitdiscretized');
jpg=evalin('caller','jpg');

   %  Create and then hide the GUI as it is being constructed.
   f = figure('Visible','off','Position',[360,500,450,285]);
   
   %  Construct the components.
   
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
          'Position',[15,110,30,10],...
          'Callback',{@runbutton_Callback}); 
   % Add "Stop" button to window
   hstop = uicontrol('Style','pushbutton',...
          'Parent', f, ...
          'String','Stop',...
          'Position',[15,90,30,10],...
          'Callback',{@stopbutton_Callback}); 
   % Add "Temperature outside = °C" text to window
   htext1 = uicontrol('Style','text','String','Temperature outside = °C',...
          'Position',[15,210,50,5]);
   % Add "SUPERVISION" text to window
   htext2 = uicontrol('Style','text','String','SUPERVISION',...
          'Position',[0,275,450,10],'FontSize', 16); 
   % Add "Temperature pannel =  °C" text to window
   htext3 = uicontrol('Style','text','String','Temperature pannel =  °C',...
          'Position',[15,200,50,5]); 
   % Add Vertical ligne to window
   htext4 = uicontrol('Style','text','String','',...
          'Position',[90,0,1,185]);
   % Add Vertical ligne to window
   htext5 = uicontrol('Style','text','String','',...
          'Position',[220,0,1,275]); 
   % Add Vertical ligne to window
   htext6 = uicontrol('Style','text','String','',...
          'Position',[350,0,1,275]);
   % Add Horizontal ligne to window
   htext7 = uicontrol('Style','text','String','',...
          'Position',[0,185,220,1]);
   % Add "provided sunshine" to window
   htext8 = uicontrol('Style','text','String','PROVIDED SUNSHINE',...
          'Position',[70,269,80,5]);
   % Add "PARAMETERS" text to window
   htextparameters = uicontrol('Style','text','String','PARAMETERS',...
          'Position',[5,179,80,5]);
   % Add "POWER" text to window
   htextpower = uicontrol('Style','text','String','POWER',...
          'Position',[120,179,80,5]);
   % Add "STABILITY OF THE GRID" text to window
   htextstability = uicontrol('Style','text','String','STABILITY OF THE GRID',...
          'Position',[250,269,80,5]);% Title    
   % Add "'All Blocks','Block D','Block E','Block C', 'Block A','Block B','Block LH','Block RH" pop-up button to window
   hpopup = uicontrol('Style','popupmenu',...
          'Parent', f, ...
          'String',{'All Blocks Monsoon','All Blocks Intermediate','All Blocks Winter','Block D Monsoon','Block D Intermediate','Block D Winter',...
          'Block E Monsoon','Block E Intermediate','Block E Winter','Block C Monsoon','Block C Intermediate','Block C Winter','Block A Monsoon','Block A Intermediate',...
          'Block A Winter','Block B Monsoon','Block B Intermediate','Block B Winter','Block LH Monsoon','Block LH Intermediate','Block LH Winter','Block RH Monsoon','Block RH Intermediate','Block RH Winter'},...
          'Position',[15,130,50,15],...
          'Callback',{@popup_menu_Callback}); 
   % Add "Quit" button to window
%    hquit = uicontrol('Style','pushbutton',...
%           'Parent', f, ...
%           'String','Quit',...
%           'Position',[415,260,30,10],...
%           'Callback',{@quitbutton_Callback});  
   % Add "h1" axe to window (Insolation)
   h1 = axes('Units','Pixels','Position',[110,200,100,60]);
   % Add "h2" axe to window (Active power)
   h2 = axes('Units','Pixels','Position',[110,110,100,60]); 
   % Add "h3" axe to window (Reactive power)
   h3 = axes('Units','Pixels','Position',[110,20,100,60]); 
   % Add "h4" axe to window (Voltage)
   h4 = axes('Units','Pixels','Position',[240,200,100,60]); 
   % Add "h5" axe to window (Frequency)
   h5 = axes('Units','Pixels','Position',[240,110,100,60]);
   % Add "h6" axe to window (SOC)
   h6 = axes('Units','Pixels','Position',[240,20,100,60]);
%    % Add Text box to window 
%    txtbox1 = uicontrol(f,'Style','edit',...
%           'String','Number of pannel',...
%           'Position',[15 160 50 5]);
%    % Add Text box to window
%    txtbox2 = uicontrol(f,'Style','edit',...
%            'String','Number of battery',...
%            'Position',[15 150 50 5]);

   % Add picture to window
   h7 = axes('Units','Pixels','Position',[10,10,70,70]); 
   imshow(jpg);
   title('Bhutan Project');
    
   % Align elements in parameters 
   align([hmonsoon,hintermediate,hwinter,hrun,hstop,htext1,htext3,htextparameters,h7,hpopup],'Center','None');
   
   % Color 
   set(hrun,'BackgroundColor', [0 1 0]);
   set(hstop,'BackgroundColor', [1 0 0]);
      
   % Initialize the GUI
   
   % Change units to normalized so components resize automatically.
   set([f,h1,h2,h3,h4,h5,h6,h7,hmonsoon,hintermediate,hwinter,hrun,hstop,htext1,htext8,htext2,htext3,htext7,htext4,htext5,htext6,htextparameters,htextstability,htextpower,hpopup],...
   'Units','normalized');

   % Full screen
   set(f, 'Units', 'Normalized', 'Position', [0 0 1 1]);
   
   % Initialize a plot in the axes.
    
   SampleTime=0.1;
   xdiscretized=1:SampleTime:24;
    
   plot(h1,xdiscretized,Ins_M,'m'); % Ins_Monsoon from DataBase.m
   xlabel(h1,'Time (Hours)');
   ylabel(h1,'Insolation (W/m²)');
   title(h1,'Insolation during the Monsoon');
   grid(h1,'on');
   set(htext1, 'String', 'Temperature outside = 26.8°C');
   set(htext3, 'String', 'Temperature pannel = 46°C');
  
   % Initialize axes
   xlabel(h4,'Time (Hours)');
   ylabel(h4,'Voltage (V)');
   title(h4,'Voltage Grid');
   grid(h4,'on');
   
   xlabel(h5,'Time (Hours)');
   ylabel(h5,'Frequency (Hz)');
   title(h5,'Frequency');
   grid(h5,'on');
   
   xlabel(h6,'Time (Hours)');
   ylabel(h6,'SOC (%)');
   title(h6,'STATE OF CHARGE BATTERY');
   grid(h6,'on');
      
    % Initialize curve for the Active power 
    plot(h2,xdiscretized,ActivePower_dataALLMonsoon);
    xlabel(h2,'Time (Hours)');
    ylabel(h2,'Active Power (kW)');
    title(h2,'Active Power All Blocks during Monsoon');
    
    % Initialize curve for the Reactive power (In our case we make an assumption, it is just the Active
    % power divided by 10).
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
   
   %  Pop-up menu callback. Read the pop-up menu Value property
   %  to determine which item is currently displayed and make it
   %  the Power_data.
      function popup_menu_Callback(source,eventdata) 
         % Determine the selected data set.
         str = get(source, 'String');
         val = get(source,'Value');
         
         % Set current data to the selected data set.
         switch str{val};           
                       
         % User selects All Blocks 
         case 'All Blocks Monsoon'  
         message2 = msgbox('The simulation will run according the consumption of All Blocks during the Monsoon');
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
         
         case 'All Blocks Intermediate'  
         message2 = msgbox('The simulation will run according the consumption of All Blocks during the Intermediate Season');
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
               
         case 'All Blocks Winter'  
         message2 = msgbox('The simulation will run according the consumption of All Blocks during the Winter');
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
         
         % User selects Block D
         case 'Block D Monsoon' 
         message2 = msgbox('The simulation will run according the consumption of the Block D during the Monsoon');
         plot(h2,xdiscretized,ActivePower_dataDMonsoon);
         title(h2,'Active Power Block D during the Monsoon');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataDMonsoon/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block D during the Monsoon');
         grid(h3,'on');
         
         case 'Block D Intermediate' 
         message2 = msgbox('The simulation will run according the consumption of the Block D during the Intermediate Season');
         plot(h2,xdiscretized,ActivePower_dataDIntermediate);
         title(h2,'Active Power Block D during the Intermediate Season');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataDIntermediate/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block D during the Intermediate Season');
         grid(h3,'on');
         
         case 'Block D Winter' 
         message2 = msgbox('The simulation will run according the consumption of the Block D during the Winter');
         plot(h2,xdiscretized,ActivePower_dataDWinter);
         title(h2,'Active Power Block D during the Winter');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataDWinter/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block D during the Winter');
         grid(h3,'on');
         
         
         % User selects Block E
         case 'Block E Monsoon' 
         message2 = msgbox('The simulation will run according the consumption of the Block E during the Monsoon');
         plot(h2,xdiscretized,ActivePower_dataEMonsoon);
         title(h2,'Active Power Block E during the Monsoon');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataEMonsoon/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block E during the Monsoon');
         grid(h3,'on');
         
         case 'Block E Intermediate' 
         message2 = msgbox('The simulation will run according the consumption of the Block E during the Intermediate Season');
         plot(h2,xdiscretized,ActivePower_dataEIntermediate);
         title(h2,'Active Power Block E during the Intermediate Season');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataEIntermediate/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block E during the Intermediate Season')
         grid(h3,'on');
         
         case 'Block E Winter' 
         message2 = msgbox('The simulation will run according the consumption of the Block E during the Winter');
         plot(h2,xdiscretized,ActivePower_dataEWinter);
         title(h2,'Active Power Block E during the Winter');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataEWinter/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block E during the Winter');
         grid(h3,'on');
         
         
         % User selects Block C
         case 'Block C Monsoon' 
         message2 = msgbox('The simulation will run according the consumption of the Block C during the Monsoon');
         plot(h2,xdiscretized,ActivePower_dataCMonsoon);
         title(h2,'Active Power Block C during the Monsoon');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataCMonsoon/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block C during the Monsoon');
         grid(h3,'on');
         
         case 'Block C Intermediate' 
         message2 = msgbox('The simulation will run according the consumption of the Block C during the Intermediate Season');
         plot(h2,xdiscretized,ActivePower_dataCIntermediate);
         title(h2,'Active Power Block C during the Intermediate Season');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataCIntermediate/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block C during the Intermediate Season');
         grid(h3,'on');
         
         case 'Block C Winter' 
         message2 = msgbox('The simulation will run according the consumption of the Block C during the Winter');
         plot(h2,xdiscretized,ActivePower_dataCWinter);
         title(h2,'Active Power Block C during the Winter');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataCWinter/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block C during the Winter');
         grid(h3,'on');
         
         % User selects Block A
         case 'Block A Monsoon' 
         message2 = msgbox('The simulation will run according the consumption of the Block A during the Monsoon');
         plot(h2,xdiscretized,ActivePower_dataAMonsoon);
         title(h2,'Active Power Block A during the Monsoon');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataAMonsoon/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block A during the Monsoon');
         grid(h3,'on');
         
         case 'Block A Intermediate' 
         message2 = msgbox('The simulation will run according the consumption of the Block A during the Intermediate Season');
         plot(h2,xdiscretized,ActivePower_dataAIntermediate);
         title(h2,'Active Power Block A during the Intermediate Season');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataAIntermediate/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block A during the Intermediate Season');
         grid(h3,'on');
         
         case 'Block A Winter' 
         message2 = msgbox('The simulation will run according the consumption of the Block A during the Winter');
         plot(h2,xdiscretized,ActivePower_dataAWinter);
         title(h2,'Active Power Block A during the Winter');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataAWinter/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block A during the Winter');
         grid(h3,'on');
         
          
         % User selects Block B
         case 'Block B Monsoon' 
         message2 = msgbox('The simulation will run according the consumption of the Block B during the Monsoon');
         plot(h2,xdiscretized,ActivePower_dataBMonsoon);
         title(h2,'Active Power Block B during the Monsoon');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataBMonsoon/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block B during the Monsoon');
         grid(h3,'on');
         
         case 'Block B Intermediate' 
         message2 = msgbox('The simulation will run according the consumption of the Block B during the Intermediate Season');
         plot(h2,xdiscretized,ActivePower_dataBIntermediate);
         title(h2,'Active Power Block B during the Intermediate Season');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataBIntermediate/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block B during the Intermediate Season');
         grid(h3,'on');
         
         case 'Block B Winter'
         message2 = msgbox('The simulation will run according the consumption of the Block B during the Winter');
         plot(h2,xdiscretized,ActivePower_dataBWinter);
         title(h2,'Active Power Block B during the Winter');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataBWinter/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block B during the Winter');
         grid(h3,'on');
         
          
         % User selects Block LH
         case 'Block LH Monsoon' 
         message2 = msgbox('The simulation will run according the consumption of the Block LH during the Monsoon');
         plot(h2,xdiscretized,ActivePower_dataLHMonsoon);
         title(h2,'Active Power Block LH during the Monsoon');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataLHMonsoon/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block LH during the Monsoon');
         grid(h3,'on');
         
         case 'Block LH Intermediate' 
         message2 = msgbox('The simulation will run according the consumption of the Block LH during the Intermediate Season');
         plot(h2,xdiscretized,ActivePower_dataLHIntermediate);
         title(h2,'Active Power Block LH during the Intermediate Season');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataLHIntermediate/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block LH during the Intermediate Season');
         grid(h3,'on');
         
         case 'Block LH Winter' 
         message2 = msgbox('The simulation will run according the consumption of the Block LH during the Winter');
         plot(h2,xdiscretized,ActivePower_dataLHWinter);
         title(h2,'Active Power Block LH during the Winter');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataLHWinter/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block LH during the Winter');
         grid(h3,'on');
        
         
         % User selects Block RH
         case 'Block RH Monsoon'
         message2 = msgbox('The simulation will run according the consumption of the Block RH during the Monsoon');
         plot(h2,xdiscretized,ActivePower_dataRHMonsoon);
         title(h2,'Active Power Block RH during the Monsoon');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataRHMonsoon/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block RH during the Monsoon');
         grid(h3,'on');
         
         case 'Block RH Intermediate'
         message2 = msgbox('The simulation will run according the consumption of the Block RH during the Intermediate Season');
         plot(h2,xdiscretized,ActivePower_dataRHIntermediate);
         title(h2,'Active Power Block RH during the Intermediate Season');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
          plot(h3,xdiscretized,ActivePower_dataRHIntermediate/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block RH during the Intermediate Season');
         grid(h3,'on');
         
         case 'Block RH Winter'
         message2 = msgbox('The simulation will run according the consumption of the Block RH during the Winter');
         plot(h2,xdiscretized,ActivePower_dataRHWinter);
         title(h2,'Active Power Block RH during the Winter');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_dataRHWinter/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block RH during the Winter');
         grid(h3,'on');
        
         end
      end
  
   % Push button callbacks 
   
   function monsoonbutton_Callback(source,eventdata,handles) 
   % Display monsoon season plot of the currently selected data.
     plot(h1,xdiscretized,Ins_M,'r'); % Ins_Monsoon from DataBase.m
     xlabel(h1,'Time (Hours)');
     ylabel(h1,'Insolation (W/m²)');
     title(h1,'Insolation during the Monsoon');
     grid(h1,'on');
     set(htext1, 'String', 'Temperature outside = 26.8°C');
     set(htext3, 'String', 'Temperature pannel = 46°C');
   end
 
   function intermediatebutton_Callback(source,eventdata,handles) 
   % Display intermediate season plot of the currently selected data.
      plot(h1,xdiscretized,Ins_I,'m');% Ins_Intermediate from DataBase.m
      xlabel(h1,'Time (Hours)');
      ylabel(h1,'Insolation (W/m²)');
      title(h1,'Insolation during the Intermediate Season');
      grid(h1,'on');
      set(htext1, 'String', 'Temperature outside = 17.4°C');
      set(htext3, 'String', 'Temperature pannel = 46°C');
   end
 
   function winterbutton_Callback(source,eventdata,handles) 
   % Display winter season plot of the currently selected data.
      plot(h1,xdiscretized,Ins_W,'m');% Ins_Winter from DataBase.m
      xlabel(h1,'Time (Hours)');
      ylabel(h1,'Insolation (W/m²)');
      title(h1,'Insolation during the Winter');
      grid(h1,'on');
      set(htext1, 'String', 'Temperature outside = 23.4°C');
      set(htext3, 'String', 'Temperature pannel = 46°C');
   end 

  function runbutton_Callback(source,eventdata,handles) 
   % Run the simulation

   message1 = msgbox('Please wait ! This simulation will take few hours');
   Microgrid_24h_Bhutan = get(handles.Microgrid_24h_Bhutan, 'String');
   stoptime = str2num(get(handles.simstoptime, 'String'));
   sim(Microgrid_24h_Bhutan, [0 stoptime]);
   
  end

  function stopbutton_Callback(source,eventdata,handles) 
   % Stop the simulation
   global GUIStopFlag;

GUIStopFlag = 1;

  end
%  function updatebutton_Callback(source,eventdata) 
%    % 
%  message1 = msgbox('Update data');
%  end
%  function quitbutton_Callback(source,eventdata) 
%    % Quit the simulation
%   f = gcf;
%    quit_reply = questdlg('Really quit this simulation?');
%    if strcmp(quit_reply,'Yes')
%       close(f);
%       % don't forget to stop the simulink
%  end
 end
