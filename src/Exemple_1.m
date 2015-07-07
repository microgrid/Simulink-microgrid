% compile command: mcc -m plotter_main.m -a ./plotfunctions -a ./parsefunctions
% Plotter
% Author: Mart Moerdijk <matlab@mmoerdijk.nl>
% Date: 28-05-2012
% TODO : Import fuctionallity doesn't work when no files in data/
% TODO : Import new files into folders, ask the user for the name of the folder.
% TOD0 : Make an automatic checking function
% TODO : Add function to load/compare two datasets
% TODO : 
function []=plotter_main(autoscan)
if exist('autoscan')
    if autoscan == true
        close all;clear all;clc;
        autoscan = true;
    else
         close all;clear all;clc;
         autoscan = false;
    end
else
    close all;clear all;clc;
    autoscan = false;
end

%% addpaths
if isdeployed()
    import plotfunctions.*
    import parsefunctions.*
else
    addpath('plotfunctions')
    addpath('parsefunctions')
    addpath('3thParty')
    addpath('3thParty/draggable')
    addpath('3thParty/str2doubleq')
    addpath('3thParty/findjobj')
end
%% Set some variables.
global currentValues window_t_min window_t_max difference L labels plotterInfoLabel selectedFolder figureHandle folders dataFolder selected;
data=[];data_copy=0;fs=0;difference=0;plotTypes=0;selectedFolder=1;plotterAxis=[];figureHandle=0;
window_t_min=0;window_t_max=0;
% File locations
dataFolder      = 'data/' ;
% labels
plotLabels=0;
plotterInfoLabel=0;
plotterEditFilterFreq=0;
plotterEvilText=0;
plotterAddEvilText=0;
% Buttons
plotterButton=0;
plotterLPF=0;
executeEval=0;
% plotterRestore=0;
filenames=[];
plotterCutoff=[];
plotterVariabels=[];
% Parse types

parseClasses_tmp(1) = parse_csv_with_headers();
global parseClasses;  
parseClasses = parseClasses_tmp ;
% Version information.
v = '0.4';
title = ['Plotter ' num2str(v) ' '] ;
%% Load plot types.
loadPlotTypes()
%% Load Parse types.
loadParseTypes()
%% Load data file names
loadFileNames();
%% Check periodically for new drives with log files

    if autoscan
        disp(['Periodically scanning the root of all drives for new compatible files']);
timerObject = timer('TimerFcn', @scanDrives,...
                 'StartDelay', 2,... % Just to delay the start to be thread save :-)
                 'Period', 1,... % Look for new files and drives each  second
                 'ExecutionMode','fixedRate');
start(timerObject)
    end

%% Declare and create all the UI objects in this GUI here so that they can
loadGui();               
%% Some java tricks to add a Combox and load button to the menubar
pause(1); % Hack for matlab 2014b
htb = findall(plotterMainWindow,'tag','FigureToolBar');
jtb = get(get(htb,'JavaContainer'),'ComponentPeer');
if ~isempty(jtb)
    jtb(1).addSeparator;

    jcb2=javax.swing.JComboBox(folders);
    jcb2h = handle(jcb2,'CallbackProperties');
    set(jcb2h, 'ActionPerformedCallback',@reloadFilenames)
  
    jtb(1).add(jcb2);
    
    jcb=javax.swing.JComboBox(mPlotTypes);
   
    jtb(1).add(jcb);
   
    jtb(1).addSeparator;
    
    jpb=javax.swing.JButton(' ');
    myIcon = fullfile(matlabroot,'/toolbox/matlab/icons/greenarrowicon.gif');
    jpb.setIcon(javax.swing.ImageIcon(myIcon));
    jbh = handle(jpb,'CallbackProperties');
    set(jbh, 'ActionPerformedCallback',@loadData)
    set(jpb, 'tooltip','<HTML>Load data.</HTML>')
    
    jpb2=javax.swing.JButton(' ');
    myIcon = fullfile(matlabroot,'/toolbox/shared/controllib/general/resources/toolstrip_icons/Refresh_24.png');
    jpb2.setIcon(javax.swing.ImageIcon(myIcon));
    jbh2 = handle(jpb2,'CallbackProperties');
    set(jbh2, 'ActionPerformedCallback',@reloadFilenames)
    set(jpb2, 'tooltip','<HTML>Reload filenames.</HTML>')
    
    jpb3=javax.swing.JButton(' ');
    myIcon = fullfile(matlabroot,'/toolbox/shared/controllib/general/resources/toolstrip_icons/Undo_24.png');
    jpb3.setIcon(javax.swing.ImageIcon(myIcon));
    jbh3 = handle(jpb3,'CallbackProperties');
    set(jbh3, 'ActionPerformedCallback',@restoreOrignalData)
    set(jpb3, 'tooltip','<HTML>Restore original data.</HTML>')

    
    jpb4=javax.swing.JButton(' ');
    myIcon = fullfile(matlabroot,'/toolbox/matlab/icons/HDF_VData.gif');
    jpb4.setIcon(javax.swing.ImageIcon(myIcon));
    jbh4 = handle(jpb4,'CallbackProperties');
    set(jbh4, 'ActionPerformedCallback',@exportData)
    set(jpb4, 'tooltip','<HTML>Export data to csv format.</HTML>')

    
    jpb5=javax.swing.JButton(' ');
    myIcon = fullfile(matlabroot,'/toolbox/matlab/icons/file_save.png');
    jpb5.setIcon(javax.swing.ImageIcon(myIcon));
    jbh5 = handle(jpb5,'CallbackProperties');
    set(jbh5, 'ActionPerformedCallback',@latex_plot)
    set(jpb5, 'tooltip','<HTML>Make a nice plot to include in you documents.<BR> <ul><li> Removes all buttons</li><li>Changes fonts to nicer fonts.</li> <li> Resizes to standard format</li> </HTML>')
    
    jpb6=javax.swing.JButton(' ');
    myIcon = fullfile(matlabroot,'/toolbox/shared/controllib/general/resources/toolstrip_icons/Clear_All.png');
    jpb6.setIcon(javax.swing.ImageIcon(myIcon));
    jpb6 = handle(jpb6,'CallbackProperties');
    set(jpb6, 'ActionPerformedCallback',@hide_file)
    set(jpb6, 'tooltip','<HTML>Hide File</HTML>')
    
    jpb7=javax.swing.JButton(' ');
    myIcon = fullfile(matlabroot,'/toolbox/shared/controllib/general/resources/toolstrip_icons/Edit.png');
    jpb7.setIcon(javax.swing.ImageIcon(myIcon));
    jpb7 = handle(jpb7,'CallbackProperties');
    set(jpb7, 'ActionPerformedCallback',@rename_file)
    set(jpb7, 'tooltip','<HTML>Rename File (Add a suffix)</HTML>')
    
    
    % Toevoegen aan de toolbar
    jtb(1).add(jpb);
    jtb(1).add(jpb2);
    jtb(1).add(jpb3);
    jtb(1).add(jpb4);
    jtb(1).add(jpb5);
    jtb(1).add(jpb6);
    jtb(1).add(jpb7);
    jtb(1).addSeparator;
    jtb(1).repaint;
    jtb(1).revalidate;
end
%% Disable the buttons 
% so that its clear that they can't be pushed.
    disableButtons();
    % function definitions
    function scanDrives(~,~)
%     disp('scanning drives..')
        newfiles = false ; 
        import java.io.*; 
        f=File(''); 
        r=f.listRoots; 
        % Loop through all disks
        for iii=1:length(r)
           % Look for supported file types in each folder to watch
           newfilelist = [] ;
           for iiT=1:length(parseClasses)
               newfilelist   = [dir([ char(r(iii)) parseClasses(iiT).filematch ]); newfilelist ] ; %#ok<AGROW>
           end
           newfilelist = { newfilelist.name } ;
           % Als er sensor files zijn gevonden
           if ~isempty(newfilelist) 
               % Dan alle sensor files door kijken
               for iT=1:length(newfilelist)
                   % En vergelijken met de oude files 
                   if ~any(strcmp(newfilelist(iT),filenames))
                       % als ze er niet tussen staan dan copieren. 
                       
                       % Nieuwe files naar de data map copieren.
                       if isvalidfile([ char(r(iii)) char(newfilelist(iT)) ])
                            set_message(['New file detected:' char(r(iii)) char(newfilelist(iT)) ]) ;
                            try
                            copyfile([ char(r(iii)) char(newfilelist(iT)) ], [ cd '/' dataFolder]);
                            catch e
                                error(e.message)
                                
                            end
                            % Opslaan dat we hebben geimporteerd.
                            newfiles = true ;
                       else
%                             set_message(['Not importing file:' char(r(iii)) char(newfilelist(iT)) ]) ;
                       end
                       
                   end
               end
               if newfiles
                   reloadFilenames();
                   set_message('Done loading new files');
               end
           
           end
           %
        end
        
    end
    % ------------------------------------------------------------
    function isvalid = isvalidfile(filename3)
%         disp(filename3)
        isvalid  = 1; 
        filesize = dir(filename3)  ;
        filesize = filesize.bytes ;
        if filesize < 10000
            isvalid = 0 ;
        end
    end
    % ------------------------------------------------------------
    function plott(~,~,plot_type)   
        % plot the right plot type
        localUpdatePlot(plot_type);
    end
    %----------------------------------------------------------------------
    function applyLowpassFilter(~,~)   
        % Callback function run when the update button is pressed
        cutoff = str2double(get(plotterEditFilterFreq, 'String'));
        % Always start with orginal data
        data = data_copy ;
        % Apply filter
        data = plotter_filter_data_low_pass(data,cutoff/fs);
    end
    %----------------------------------------------------------------------
    function restoreOrignalData(~,~)   
        % Restore original data.
        data = data_copy ;
    end
    %----------------------------------------------------------------------
    function hcbWhyLabel(~,~)
    % :-)
        set(plotterWhyLabel,'String',evalc('why'));
    end
    %----------------------------------------------------------------------
    function rename_file(~,~)
        newfilename = char(inputdlg('Enter suffix for this file:'));
        filenameindex = get(jcb,'SelectedIndex')+1;
        filename = char([ 'data/' char(folders(selectedFolder)) char(filenames(filenameindex)) ]);
        [a,n,e]   = fileparts(filename);
        newfilename = [ a  n '_' newfilename e ] ;
        disp(newfilename)
        pause(0.1)
        try
            movefile(filename,newfilename);
        catch e
            msgbox(e,'An error has occured','error') ;
        end
        reloadFilenames(0,0);
    end
    %----------------------------------------------------------------------
    function hide_file(~,~)
     
        filenameindex = get(jcb,'SelectedIndex')+1;
        filename = [ 'data/' char(folders(selectedFolder)) char(filenames(filenameindex)) ];
        hidefilename = [ 'data/' char(folders(selectedFolder)) 'hide_' char(filenames(filenameindex)) '_this_file' ] ;
        movefile(filename,hidefilename);
        reloadFilenames(0,0);
        loadData(0,0);
        plott('','','separate')
    end
    %----------------------------------------------------------------------
    function loadData(~,~)
        % Get the filename to load
        filenameindex = get(jcb,'SelectedIndex')+1;
        filename = [ char(folders(selectedFolder)) char(filenames(filenameindex)) ];
        % Disable buttons
        disableButtons();
        % Set message to gui
        set_message(['Loading:', filename ' please be patient.']);
        % Select the correct parser
        parser_selected = false ;
        for iii=1:length(parseClasses)
            parser = parseClasses(iii) ; 
            [~,n,e]   = fileparts(filename) ;
            filename2        = [ n e ] ;
%             if strncmp(filename2,parser.filematch,length(parser.filematch))
            if regexpi(filename2,regexptranslate('wildcard',parser.filematch))    
               set_message(['Selected:' parser.Name ' for parsing the file'])
               parser_selected = true ; 
               break;  
            end
        end
        % Did we find the correct parser for this file type?
        if ~parser_selected 
            msgbox('No Parser found for this file type, aborting.') ;
            return;
        end
            
        % parse data
        try
        [L.TIME,labels,data] = parser.parseData([dataFolder filename]) ;
        data_copy = data ;
        catch e
            msgbox('Error loading file, are you sure you are using the correct parser?');
            rethrow(e)
        end 
        try 
            if length(findpeaks(data(:,L.TIME),'minpeakdistance',1)) > 2
            msgbox('The time collum is not strickly cumulative. Plots might be strange.') 
            end
        catch e %#ok<NASGU>
            warning('time check not working')
        end
        set(plotterVariabels,'Value',1:length(labels),'String',labels,'Max', length(labels))
        % Estimate sample freq
        estimateSampleFreq()
        % Set the cut off freq to gui
        set(plotterCutoff,'String', ['Cut off freq:[Hz] Est fs:: ' num2str(fs) ' Hz']) ;
        % Set filename and freq to gui.
        set_message(['Loaded:' filename ' Est fs: ' num2str(fs) ' Hz'] )
        % enable buttons
        enableButtons();
        % Let sound a sound 
        sound(1:1:5);
         plott('','','separate')
    end
    %----------------------------------------------------------------------
    function localUpdatePlot(type)
        % Get selected variables
        selected = get(plotterVariabels,'Value') ;
        % Clear the plot erea
        subplot(1,1,1);cla;
        % Just wait a for it to happen
        pause(0.1);
        % Let know that we are going to plot
%         set_message('Start plotting!' )
        % Plot data
        plot_data(data,type,selected);
        % Let know that we are done
%         set_message('Done!' )
    end
    %----------------------------------------------------------------------
    function set_message(message)
        set(plotterInfoLabel,'String', char(message)) ;
        pause(0.1);
        disp(message);
    end
    %----------------------------------------------------------------------
    function disableButtons()
        for button=plotterButton
            set(button,'Enable','off') ;
        end
        set(plotterLPF,'Enable','off') ;
        set(executeEval,'Enable','off') ;
        set(plotterAddEvilText,'Enable','off') ;
        
%         set(plotterRestore,'Enable','off') ;
    end
    %----------------------------------------------------------------------
    function enableButtons()
        for button=plotterButton
            set(button,'Enable','on') ;
        end
        set(plotterLPF,'Enable','on') ; 
        set(executeEval,'Enable','on') ;
        set(plotterAddEvilText,'Enable','on') ;

%         set(plotterRestore,'Enable','on') ;
    end
    %----------------------------------------------------------------------
    function loadPlotTypes()
        plotClasses     = dir('plotfunctions/plot_*.m');
        plotLabels      = cell(length(plotClasses),1);
        plotTypes       = cell(length(plotClasses),1);
        p(1) = plot_fft();
        for iii=1:length(plotClasses)
            [~,plotType1] = strtok(strtok(plotClasses(iii).name,'.'),'_') ;
            
            p(iii) = eval(['plot_' plotType1(2:end) '();']) ; %#ok<AGROW>
           
            plotLabels(iii) = {p(iii).plotLabel()};  
            plotTypes(iii) = {p(iii).plotType()};
        end
    end
    %----------------------------------------------------------------------
    function loadParseTypes()
      parseClasseslist     = dir('parsefunctions/*.m');
      for iii=1:length(parseClasseslist)
            eval(['parseClasses(' num2str(iii) ') = ' parseClasseslist(iii).name(1:end-2) '();']) 
      end
    end
    %----------------------------------------------------------------------
    function loadFileNames
        
        % Make sure we can save all folders
        tmp_folders   = dir([dataFolder '*']);
        folders = cell(length(tmp_folders)+2,1) ;
        
        ii=1;
        for file={tmp_folders.name}
            tmp_file_name = [dataFolder '/' char(file) ] ;
            if isdir(tmp_file_name)
                 folders(ii) = cellstr([char(file) '/']) ;
                ii=ii+1;    
            end
        end
        folders(ii) = {'/'} ;
        folders(1:2) = [];
        folders(cellfun(@isempty,folders)) = [];
        folders = flipud(folders);
        datafiles = [];
        % Find all file that match a data parser
        for iii=1:length(parseClasses)
            datafiles   = [dir([dataFolder char(folders(selectedFolder)) parseClasses(iii).filematch ]); datafiles ] ; %#ok<AGROW>
        end
        iii=1;
        sizes = [datafiles.bytes]/1000000 ; % File size in Mb
        
      
        mPlotTypes = cell(length(sizes),1);
        for name = {datafiles.name}
           % Add the file size to the filename.
           mPlotTypes(iii) =  cellstr([ char(name) ' (' num2str(sizes(iii)) 'Mb)' ]) ;
           iii=iii+1;
        end
        % Reversve the filenames so that the newest files are first.
        mPlotTypes = flipud(mPlotTypes);
        % Also save a list of filenames to load the right file.
        filenames = fliplr({datafiles.name});

    end
    %----------------------------------------------------------------------
    function reloadFilenames(~,~)
        selectedFolder=get(jcb2,'SelectedIndex')+1;
        % load file names 
        loadFileNames()
        % Set filenames to label
        jcb.removeAllItems();
        jcb.setModel(javax.swing.JComboBox(mPlotTypes).getModel());
%         set(jcb,'Values',mPlotTypes) ;
    end
    %----------------------------------------------------------------------
    function estimateSampleFreq()
        % Find the number of samples
        N = length(data(:,1))-1;
        
        % Find observation time in sec
        T = (data(end,L.TIME)- data(1,L.TIME))/1000 ;
        
        % Estimation of sample freq
        fs = N/T ;
    end
    %----------------------------------------------------------------------
    function exportData(~,~)
        filename = uiputfile('*.csv','Save data as csv file') ;
        if length(filename) > 1 
            
            fid = fopen(filename, 'w');
            if fid == -1; error('Cannot open file: %s', filename); end
            fprintf(fid, '%s,', labels{1:end-1});
            fprintf(fid, '%s', labels{end});
            fprintf(fid, '\n');
            fclose(fid);
            dlmwrite(filename, data, 'precision', '%.6f', ...
             'newline', 'pc','-append');
            set_message(['File saved as:' filename ] )
        end
        
    end
    function onWindowClose(~,~)
        if exist('timerObject')
            stop(timerObject);
            delete(timerObject);
        end
    end
    function addEvilEvalToDataSet(~,~)
        % Plot
        selected = get(plotterVariabels,'Value') ;
        x = data(:,selected(1)); %#ok<NASGU>
        if length(selected) > 1
            y = data(:,selected(2)); %#ok<NASGU>
        end
        evilEvalText = get(plotterEvilText,'String');
        try
            x = eval(evilEvalText);
        catch e 
            msgbox('Error evaluating expression, if you used x and y did you also select two signals?','Error','error');
        end
        data(:,end+1) = x ;
        labels(end+1) = {[evilEvalText 'x=' char(labels(selected(1)))]}; 
        set(plotterVariabels,'Value',1:length(labels),'String',char(labels),'Max', length(labels))
    end
    function evilEval(~,~)
        % Clear the plot erea
        subplot(1,1,1);cla;
        % Just wait a minut for it to happen
        pause(0.1);
        % Plot
        selected = get(plotterVariabels,'Value') ;
        x = data(:,selected(1)); %#ok<NASGU>
        if length(selected) > 1
            y = data(:,selected(2)); %#ok<NASGU>
        end
        evilEvalText = get(plotterEvilText,'String');
        try
        x = eval(evilEvalText);
        catch error
            msgbox(error.identifier);
            return
        end
        plot(data(:,L.TIME)/1000,x,'-r','LineWidth',3);hold all;
        plot_data(data,'together',selected);
        
    end
    %----------------------------------------------------------------------
    function loadGui
        % be used in any functions
        plotterMainWindow    =   figure('Name' ,title ,... % the main GUI figure
                                'Toolbar','figure', ...
                                'NumberTitle','off', ...                       
                                'Color', get(0, 'defaultuicontrolbackgroundcolor'),...
                                'DeleteFcn',@onWindowClose);
        
        figureHandle = get(plotterMainWindow,'handle') ;
        % We want to set the size of the window and make sure it stays inside the
        % window but not the location
        pos = get(plotterMainWindow,'OuterPosition');
        set(plotterMainWindow,'OuterPosition',[pos(1), pos(2)-100, 800, 600])

        plotterAxis      =   axes(...         % the axes for plotting selected plot
                                'Parent', plotterMainWindow, ...
                                'Units', 'normalized', ...
                                 'Position',[0.15 0.1 0.75 0.85]);
           
        text( 0.2,0.5,{'1. Select a file and press load(green arrow) and wait.(See bottom left corner)';...
                                    '2. Select one of the plotting options.';...
                                    '3. Drag the green bar to see the value of the variables on that time instance.';...
                                    'You can also apply a low pass filter when neassary. In selected plots stats are ';...
                                    'showed, the window over which these stats are calulated can be selected by ';... 
                                    'dragging the blue and red borders.';...
                                    '';...
                                   
                                    '';...
                                    'Tip: Maximize to see tooltip at the buttons';...
                                   },'Unit','Normalized','Parent',plotterAxis);

        plotterInfoLabel=   uicontrol(    'Parent', plotterMainWindow, ...
                                'Units', 'normalized',...
                                'Position',[0 0 0.5 0.05],...                       
                                'String','Select text file',...
                                'HorizontalAlignment','left',...
                                'Style','text');
        % Set up the plot buttons                    
        plotterButton = zeros(length(plotLabels),1);
        for iii=1:length(plotLabels)
            plotterButton(iii)  =   uicontrol(...    % button for updating selected plot 
                                'Parent', plotterMainWindow, ...
                                'Units','normalized',...
                                'HandleVisibility','callback', ...
                                'Position',[mod(iii-1,2)*0.05 0.98-iii*0.02+mod(iii-1,2)*0.02 0.05 0.04],...
                                'String',char(plotLabels(iii)),...
                                'Callback', {@plott,char(plotTypes(iii))});

        end
   plotterAddEvilText  =   uicontrol(...    
                                'Parent', plotterMainWindow, ...
                                'Units','normalized',...
                                'HandleVisibility','callback', ...
                                'Position',[0 0.65 0.1 0.05],...
                                'String','Add eval to dataset',...
                                'Callback', @addEvilEvalToDataSet);
      
 plotterEvilText  =   uicontrol(...    
                                'Parent', plotterMainWindow, ...
                                'Units','normalized',...
                                'HandleVisibility','callback', ...
                                'Position',[0 0.75 0.1 0.05],...
                                'String','10*x+10*y',...
                                'Style','edit',...
                                'Callback', @evilEval);

        executeEval  =   uicontrol(...    
                                'Parent', plotterMainWindow, ...
                                'Units','normalized',...
                                'HandleVisibility','callback', ...
                                'Position',[0 0.70 0.1 0.05],...
                                'String','Eval',...
                                'Callback', @evilEval);
        plotterLPF  =   uicontrol(...    
                                'Parent', plotterMainWindow, ...
                                'Units','normalized',...
                                'HandleVisibility','callback', ...
                                'Position',[0 0.60 0.05 0.05],...
                                'String','Apply Lowpass filter',...
                                'Callback', @applyLowpassFilter);                     
% 
%         plotterRestore  =   uicontrol(...    % button for updating selected plot 
%                                 'Parent', plotterMainWindow, ...
%                                 'Units','normalized',...
%                                 'HandleVisibility','callback', ...
%                                 'Position',[0 0.55 0.05 0.05],...
%                                 'String','Restore raw data.',...
%                                 'Callback', @restoreOrignalData);

        plotterEditFilterFreq  =   uicontrol(  ...  % button for updating selected plot 
                                'Style','edit',...
                                'BackgroundColor','white',...
                                'Parent', plotterMainWindow, ...
                                'Units','normalized',...
                                'Position',[0.05 0.60 0.025 0.05],...
                                'String','4'...
                                );

        plotterCutoff=   uicontrol(    'Parent', plotterMainWindow, ...
                                'Units','normalized',...
                                'Position',[0.075 0.60 0.025 0.035],...
                                'String','Hz',...
                                'HorizontalAlignment','left',...
                                'Style','text');
                            
        plotterWhyLabel=   uicontrol(    'Parent', plotterMainWindow, ...
                                'Units','normalized',...
                                'Position',[0.5 0 0.5 0.05],...
                                'String','Cuttoff freq [Hz]',...
                                'HorizontalAlignment','right',...
                                'String',evalc('why'),...
                                'Style','text',...
                                'Callback', @hcbWhyLabel); %#ok<NASGU>

        currentValues =   uicontrol(    'Parent', plotterMainWindow, ...
                                            'Units','normalized',...
                                            'Position',[0.91 0.05 0.090 0.90],...
                                            'String','',...
                                            'HorizontalAlignment','left',...
                                            'Style','text');        

        plotterVariabels  =   uicontrol(...    % button for updating selected plot 
                                'Parent', plotterMainWindow, ...
                                'Units','normalized',...
                                'HandleVisibility','callback', ...
                                'Position',[0 0.1 0.1 0.500],...
                                'String',labels(1:end),...
                                'Style','listbox',...
                                'Min', 1, ...
                                'Max', length(labels), ...
                                'FontSize', 11 ...
                             );
                         
                         
        
    end
    
    function latex_plot(~,~)
    % Set up the figures 
    fig = figure ;
    
    copyobj(get(plotterMainWindow,'children'),fig);
    h=findobj('style','edit');
    delete(h)
    h=findobj('style','text');
    delete(h)
    h=findobj('Type','line','-not','ButtonDownFcn',[]);
      delete(h)
    pause(0.1)
    % size.
    set(fig,'Position',[50 150 1000 800]);
    % Color
    set(fig,'Color','w');
    % Fonts
    try
        set( gca ,  'FontName'   , 'Helvetica' );
    catch %#ok<CTCH>
        1;
    end
    %
    children = get(fig,'Children');
%     Voor alle sub plots de waarden aanpassen
    for ii=1:numel(children)
        try
        title = get(children(ii),'Title') ;
        catch%#ok<CTCH>
%             warning('No child')
        end
        try
        text = get(children(ii),'Text') ;
        catch%#ok<CTCH>
%             warning('No child')
        end
        
        try
        xlabel = get(children(ii),'Xlabel') ;
        catch%#ok<CTCH>
%             warning('No child')
        end
        try
        ylabel = get(children(ii),'Ylabel') ;
        catch%#ok<CTCH>
%             warning('No child')
        end
        %get(title,'String');
        try
            set(xlabel,'FontName','AvantGarde','FontSize',10)
        catch%#ok<CTCH>
%             warning('No child')
        end
        try
        set(ylabel,'FontName','AvantGarde','FontSize',10)
        catch%#ok<CTCH>
%             warning('No child')
        end
        try
        set(title,'FontName','AvantGarde','FontSize',12,'FontWeight','bold')
        catch%#ok<CTCH>
%             warning('No child')
        end
        
        try
        set(text,'FontName','AvantGarde','FontSize',10,'FontWeight','bold')
        catch%#ok<CTCH>
%             warning('No child')
        end
    end
        %     Save file
        [filename,path] = uiputfile('*.eps','Save data as eps file') ;
        if length(filename) > 1 
            saveas(fig,[path '/' filename], 'psc2');
%             saveas(fig,[path '/' filename]);

        end
%     gca = plotterMainWindow;  
    end
    

end 
