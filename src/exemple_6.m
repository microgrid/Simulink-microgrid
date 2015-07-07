function myui
    % Create a figure and axes
    f = figure('Visible','off');
    ax = axes('Units','pixels');
    surf(peaks)
    
    % Create pop-up menu
    popup = uicontrol('Style', 'popup',...
           'String', {'parula','jet','hsv','hot','cool','gray'},...
           'Position', [20 340 100 50],...
           'Callback', @setmap);    
    
   % Create push button
    btn = uicontrol('Style', 'pushbutton', 'String', 'Clear',...
        'Position', [20 20 50 20],...
        'Callback', 'cla');       

   % Create slider
    sld = uicontrol('Style', 'slider',...
        'Min',1,'Max',50,'Value',41,...
        'Position', [400 20 120 20],...
        'Callback', @surfzlim); 
					
    % Add a text uicontrol to label the slider.
    txt = uicontrol('Style','text',...
        'Position',[400 45 120 20],...
        'String','Vertical Exaggeration');
    
    % Make figure visble after adding all components
    set(f,'Visible','on')
%     f.Visible = 'on';
    % This code uses dot notation to set properties. 
    % Dot notation runs in R2014b and later.
    % For R2014a and earlier: set(f,'Visible','on');
    
    function setmap(source,callbackdata)
%         val = source.Value;
%         maps = source.String;
        % For R2014a and earlier: 
        val = get(source,'Value');
        maps = get(source,'String'); 

        newmap = maps{val};
        colormap(newmap);
    end

    function surfzlim(source,callbackdata)
%         val = 51 - source.Value;
        % For R2014a and earlier:
        val = 51 - get(source,'Value');

        zlim(ax,[-val val]);
    end
end