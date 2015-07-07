function Supervision
      
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
          'Position',[15,200,50,5]);
   % Add "SUPERVISION" text to window
   htext2 = uicontrol('Style','text','String','SUPERVISION',...
          'Position',[0,275,450,10],'FontSize', 16); 
   % Add "Temperature pannel =  °C" text to window
   htext3 = uicontrol('Style','text','String','Temperature pannel =  °C',...
          'Position',[15,190,50,5]); 
   % Add Vertical ligne to window
   htext4 = uicontrol('Style','text','String','',...
          'Position',[90,0,1,275]);
   % Add Vertical ligne to window
   htext5 = uicontrol('Style','text','String','',...
          'Position',[220,0,1,275]); 
   % Add Vertical ligne to window
   htext6 = uicontrol('Style','text','String','',...
          'Position',[350,0,1,275]);
   % Add "PARAMETERS" text to window
   htextparameters = uicontrol('Style','text','String','PARAMETERS',...
          'Position',[5,269,80,5]);
   % Add "POWER" text to window
   htextpower = uicontrol('Style','text','String','POWER',...
          'Position',[120,269,80,5]);
   % Add "STABILITY OF THE GRID" text to window
   htextstability = uicontrol('Style','text','String','STABILITY OF THE GRID',...
          'Position',[250,269,80,5]);% Title    
   % Add "'All Blocks','Block D','Block E','Block C', 'Block A','Block B','Block LH','Block RH" pop-up button to window
   hpopup = uicontrol('Style','popupmenu',...
          'Parent', f, ...
          'String',{'All Blocks','Block D','Block E','Block C', 'Block A','Block B','Block LH','Block RH'},...
          'Position',[15,165,50,15],...
          'Callback',{@popup_menu_Callback});
   % Add "Stop" button to window
   hupdate = uicontrol('Style','pushbutton',...
          'Parent', f, ...
          'String','Update',...
          'Position',[15,125,30,10],...
          'Callback',{@updatebutton_Callback}); 
   % Add "Stop" button to window
   hquit = uicontrol('Style','pushbutton',...
          'Parent', f, ...
          'String','Quit',...
          'Position',[415,260,30,10],...
          'Callback',{@quitbutton_Callback});  
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
   % Add Text box to window 
   txtbox1 = uicontrol(f,'Style','edit',...
          'String','Number of pannel',...
          'Position',[15 160 50 5]);
   % Add Text box to window
   txtbox2 = uicontrol(f,'Style','edit',...
           'String','Number of battery',...
           'Position',[15 150 50 5]);
   % Add picture to window
   h7 = axes('Units','Pixels','Position',[10,10,70,70]); 
   jpg=imread('img\bhutan.jpg');
   imshow(jpg);
   title('Bhutan Project');
   
   % Align elements in parameters 
   align([hmonsoon,hintermediate,hwinter,hrun,hstop,htext1,htext3,txtbox1,txtbox2,hupdate,htextparameters,h7,hpopup],'Center','None');
   
   % Color 
   set(hrun,'BackgroundColor', [0 1 0]);
   set(hstop,'BackgroundColor', [1 0 0]);
   
   % Create the data insolation to plot.
   
   SampleTime=0.1;
   xdiscretized=1:SampleTime:24;
   Insolation_data = normpdf(xdiscretized,12,1.7); % Normal law
   
   % Initialize the GUI
   
   % Change units to normalized so components resize automatically.
   set([f,h1,h2,h3,h4,h5,h6,h7,hmonsoon,hintermediate,hwinter,hrun,hstop,hquit,htext1,hupdate,htext2,htext3,txtbox2,htext4,htext5,htext6,txtbox1,htextparameters,htextstability,htextpower,hpopup],...
   'Units','normalized');

   % Full screen
   set(f, 'Units', 'Normalized', 'Position', [0 0 1 1]);
   
   % Initialize a plot in the axes.
   plot(h1,xdiscretized,Insolation_data*3990,'m');
   xlabel(h1,'Time (Hours)');
   ylabel(h1,'Insolation (W/m²)');
   title(h1,'SEASON Monsoon');
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
   title(h6,'SOC');
   grid(h6,'on');
   
  
% Import data from the files 

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

           
% linear regression with a polynomial approach for the Active power of the load  
    p = polyfit(Time,customerRHWinter,10); % Data choice from pushbutton SEASONS
    yfit = polyval(p,Time);
    yfitdiscretized=polyval(p,xdiscretized);

  % Delete values below zero for the final curve for the Active power of the load
    nrows = 1;
    ncols = (23/SampleTime)+1;
    newyfitdiscretized=yfitdiscretized;
r=1;
    for c = 1:ncols

        if  yfitdiscretized(r,c)<0
            newyfitdiscretized(r,c) = 0;
        else
   newyfitdiscretized(r,c)= yfitdiscretized(r,c);
        end
    end
    
    % Initialize curve for the Active power 
    plot(h2,xdiscretized,newyfitdiscretized);
    xlabel(h2,'Time (Hours)');
    ylabel(h2,'Active Power (kW)');
    title(h2,'Active Power All Blocks');
    
    % Initialize curve for the Reactive power (In our case we make an assumption, it is just the Active
    % power divided by 10).
    plot(h3,xdiscretized,newyfitdiscretized/10,'r');
    xlabel(h3,'Time (Hours)');
    ylabel(h3,'Reactive Power (kVAR)');
    title(h3,'Reactive Power All Blocks')

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
         case 'All Blocks' 
         ActivePower_data=newyfitdiscretized/100;
         message2 = msgbox('The simulation will run according the consumption of All Blocks');
         plot(h2,xdiscretized,ActivePower_data);
         title(h2,'Active Power All Blocks');
         xlabel(h2,'Time (Hours)');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_data/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power All Blocks')
         grid(h3,'on');
         Block='All';
         
         % User selects Block D
         case 'Block D' 
         ActivePower_data=newyfitdiscretized/2;
         plot(h2,xdiscretized,ActivePower_data);
         title(h2,'Active Power Block D');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_data/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block D');
         message2 = msgbox('The simulation will run according the consumption of the Block D');
         grid(h3,'on');
         Block='D';
         
         % User selects Block E
         case 'Block E' 
         ActivePower_data=newyfitdiscretized/23;
         plot(h2,xdiscretized,ActivePower_data);
         title(h2,'Active Power Block E');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_data/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block E');
         message2 = msgbox('The simulation will run according the consumption of the Block E');
         grid(h3,'on');
         Block='E';
         
         % User selects Block C
         case 'Block C' 
         ActivePower_data=newyfitdiscretized/5;
         plot(h2,xdiscretized,ActivePower_data);
         title(h2,'Active Power Block C');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_data/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block C');
         message2 = msgbox('The simulation will run according the consumption of the Block C');
         grid(h3,'on');
         Block='C';
         
         % User selects Block A
         case 'Block A' 
         ActivePower_data=newyfitdiscretized/9;
         plot(h2,xdiscretized,ActivePower_data);
         title(h2,'Active Power Block A');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_data/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block A');
         message2 = msgbox('The simulation will run according the consumption of the Block A');
         grid(h3,'on');
         Block='A';
          
         % User selects Block B
         case 'Block B' 
         ActivePower_data=newyfitdiscretized/7;
         plot(h2,xdiscretized,ActivePower_data);
         title(h2,'Active Power Block B');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_data/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block B');
         message2 = msgbox('The simulation will run according the consumption of the Block B');
         grid(h3,'on');
         Block='B';
          
         % User selects Block LH
         case 'Block LH' 
         ActivePower_data=newyfitdiscretized/34;
         plot(h2,xdiscretized,ActivePower_data);
         title(h2,'Active Power Block LH');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
         plot(h3,xdiscretized,ActivePower_data/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block LH');
         message2 = msgbox('The simulation will run according the consumption of the Block LH');
         grid(h3,'on');
         Block='LH';
         
         % User selects Block RH
         case 'Block RH' 
         ActivePower_data=newyfitdiscretized/34;
         plot(h2,xdiscretized,ActivePower_data);
         title(h2,'Active Power Block RH');
         ylabel(h2,'Active Power (kW)');
         grid(h2,'on');
          plot(h3,xdiscretized,ActivePower_data/10,'r');
         xlabel(h3,'Time (Hours)');
         ylabel(h3,'Reactive Power (kVAR)');
         title(h3,'Reactive Power Block RH');
         message2 = msgbox('The simulation will run according the consumption of the Block RH');
         grid(h3,'on');
         Block='RH';
         
         end
      end
  
   % Push button callbacks 
   
   function monsoonbutton_Callback(source,eventdata) 
   % Display monsoon season plot of the currently selected data.
     plot(h1,xdiscretized,Insolation_data*3990,'m');
     xlabel(h1,'Time (Hours)');
     ylabel(h1,'Insolation (W/m²)');
     title(h1,'SEASON Monsoon');
     grid(h1,'on');
     set(htext1, 'String', 'Temperature outside = 26.8°C');
     set(htext3, 'String', 'Temperature pannel = 46°C');
     Season = guidata(hmonsoon_handle)
   end
 
   function intermediatebutton_Callback(source,eventdata) 
   % Display intermediate season plot of the currently selected data.
      plot(h1,xdiscretized,Insolation_data*4583,'m');
      xlabel(h1,'Time (Hours)');
      ylabel(h1,'Insolation (W/m²)');
      title(h1,'SEASON Intermediate');
      grid(h1,'on');
      set(htext1, 'String', 'Temperature outside = 17.4°C');
      set(htext3, 'String', 'Temperature pannel = 46°C');
      Season = guidata(hintermediate_handle)
   end
 
   function winterbutton_Callback(source,eventdata) 
   % Display winter season plot of the currently selected data.
      plot(h1,xdiscretized,Insolation_data*4888,'m');
      xlabel(h1,'Time (Hours)');
      ylabel(h1,'Insolation (W/m²)');
      title(h1,'SEASON Winter');
      grid(h1,'on');
      set(htext1, 'String', 'Temperature outside = 23.4°C');
      set(htext3, 'String', 'Temperature pannel = 46°C');
      Season = guidata(hwinter_handle)
   end 

  function runbutton_Callback(source,eventdata,handles) 
   % Run the simulation
   options = simset('SrcWorkspace','current');
   sim('Microgrid_24h_Bhutan',[],options);


 % Send the Power from the selected block to the simulink

   message1 = msgbox('Please wait ! This simulation will take few hours');
   sim('Microgrid_24h_Bhutan');
   
  end

  function stopbutton_Callback(source,eventdata,handles) 
   % Stop the simulation

  end

 function quitbutton_Callback(source,eventdata) 
   % Quit the simulation
  f = gcf;
   quit_reply = questdlg('Really quit this simulation?');
   if strcmp(quit_reply,'Yes')
      close(f);
      % don't forget to stop the simulink
 end
 end
end 