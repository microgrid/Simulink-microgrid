
  % Create the data insolation to plot.
   SampleTime=0.1;
   xdiscretized=1:SampleTime:24;
   Insolation_data = normpdf(xdiscretized,12,1.7); % Normal law
   Ins_Monsoon=Insolation_data*3990;
   Ins_Intermediate=Insolation_data*4583;
   Ins_Winter=Insolation_data*4888;
   
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
    
    % Block All (Monsoon)
    p = polyfit(Time,customerAllMonsoon,10); % Data choice from pushbutton SEASONS
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
    
     
    % Block All (Intermediate)
     p = polyfit(Time,customerAllIntermediate,10); % Data choice from pushbutton SEASONS
    yfit = polyval(p,Time);
    yfitdiscretized=polyval(p,xdiscretized);

  % Delete values below zero for the final curve for the Active power of the load
    newyfitdiscretized=yfitdiscretized;
r=1;
    for c = 1:ncols

        if  yfitdiscretized(r,c)<0
            newyfitdiscretized(r,c) = 0;
        else
   newyfitdiscretized(r,c)= yfitdiscretized(r,c);
        end
    end
    
    
    % Block All (Winter)
     p = polyfit(Time,customerAllWinter,10); % Data choice from pushbutton SEASONS
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
  
    
      % Block D (Monsoon)
    p = polyfit(Time,customerDMonsoon,10); % Data choice from pushbutton SEASONS
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
    
    
    % Block D (Intermediate)
     p = polyfit(Time,customerDIntermediate,10); % Data choice from pushbutton SEASONS
    yfit = polyval(p,Time);
    yfitdiscretized=polyval(p,xdiscretized);

  % Delete values below zero for the final curve for the Active power of the load
    newyfitdiscretized=yfitdiscretized;
r=1;
    for c = 1:ncols

        if  yfitdiscretized(r,c)<0
            newyfitdiscretized(r,c) = 0;
        else
   newyfitdiscretized(r,c)= yfitdiscretized(r,c);
        end
    end
    
    
    % Block D (Winter)
     p = polyfit(Time,customerDWinter,10); % Data choice from pushbutton SEASONS
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
    
    
      % Block E (Monsoon)
    p = polyfit(Time,customerEMonsoon,10); % Data choice from pushbutton SEASONS
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
    
    
    % Block E (Intermediate)
     p = polyfit(Time,customerEIntermediate,10); % Data choice from pushbutton SEASONS
    yfit = polyval(p,Time);
    yfitdiscretized=polyval(p,xdiscretized);

  % Delete values below zero for the final curve for the Active power of the load
    newyfitdiscretized=yfitdiscretized;
r=1;
    for c = 1:ncols

        if  yfitdiscretized(r,c)<0
            newyfitdiscretized(r,c) = 0;
        else
   newyfitdiscretized(r,c)= yfitdiscretized(r,c);
        end
    end
    
    
    % Block E (Winter)
     p = polyfit(Time,customerEWinter,10); % Data choice from pushbutton SEASONS
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
    
    
 % Block C (Monsoon)
    p = polyfit(Time,customerCMonsoon,10); % Data choice from pushbutton SEASONS
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
    
    
    % Block C (Intermediate)
     p = polyfit(Time,customerCIntermediate,10); % Data choice from pushbutton SEASONS
    yfit = polyval(p,Time);
    yfitdiscretized=polyval(p,xdiscretized);

  % Delete values below zero for the final curve for the Active power of the load
    newyfitdiscretized=yfitdiscretized;
r=1;
    for c = 1:ncols

        if  yfitdiscretized(r,c)<0
            newyfitdiscretized(r,c) = 0;
        else
   newyfitdiscretized(r,c)= yfitdiscretized(r,c);
        end
    end
    
    
    % Block C (Winter)
     p = polyfit(Time,customerCWinter,10); % Data choice from pushbutton SEASONS
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
    
    
    % Block A (Monsoon)
    p = polyfit(Time,customerAMonsoon,10); % Data choice from pushbutton SEASONS
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
    
    
    % Block A (Intermediate)
     p = polyfit(Time,customerAIntermediate,10); % Data choice from pushbutton SEASONS
    yfit = polyval(p,Time);
    yfitdiscretized=polyval(p,xdiscretized);

  % Delete values below zero for the final curve for the Active power of the load
    newyfitdiscretized=yfitdiscretized;
r=1;
    for c = 1:ncols

        if  yfitdiscretized(r,c)<0
            newyfitdiscretized(r,c) = 0;
        else
   newyfitdiscretized(r,c)= yfitdiscretized(r,c);
        end
    end
    
    
    % Block A (Winter)
     p = polyfit(Time,customerAWinter,10); % Data choice from pushbutton SEASONS
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
    
    
    % Block B (Monsoon)
    p = polyfit(Time,customerBMonsoon,10); % Data choice from pushbutton SEASONS
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
    
   
    % Block B (Intermediate)
     p = polyfit(Time,customerBIntermediate,10); % Data choice from pushbutton SEASONS
    yfit = polyval(p,Time);
    yfitdiscretized=polyval(p,xdiscretized);

  % Delete values below zero for the final curve for the Active power of the load
    newyfitdiscretized=yfitdiscretized;
r=1;
    for c = 1:ncols

        if  yfitdiscretized(r,c)<0
            newyfitdiscretized(r,c) = 0;
        else
   newyfitdiscretized(r,c)= yfitdiscretized(r,c);
        end
    end
    
    
    % Block B (Winter)
     p = polyfit(Time,customerBWinter,10); % Data choice from pushbutton SEASONS
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
    
    
    % Block LH (Monsoon)
    p = polyfit(Time,customerLHMonsoon,10); % Data choice from pushbutton SEASONS
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
    
    
    % Block LH (Intermediate)
     p = polyfit(Time,customerLHIntermediate,10); % Data choice from pushbutton SEASONS
    yfit = polyval(p,Time);
    yfitdiscretized=polyval(p,xdiscretized);

  % Delete values below zero for the final curve for the Active power of the load
    newyfitdiscretized=yfitdiscretized;
r=1;
    for c = 1:ncols

        if  yfitdiscretized(r,c)<0
            newyfitdiscretized(r,c) = 0;
        else
   newyfitdiscretized(r,c)= yfitdiscretized(r,c);
        end
    end
    
    
    % Block LH (Winter)
     p = polyfit(Time,customerLHWinter,10); % Data choice from pushbutton SEASONS
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
    
    
    % Block RH (Monsoon)
    p = polyfit(Time,customerRHMonsoon,10); % Data choice from pushbutton SEASONS
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
    
    
    % Block RH (Intermediate)
     p = polyfit(Time,customerRHIntermediate,10); % Data choice from pushbutton SEASONS
    yfit = polyval(p,Time);
    yfitdiscretized=polyval(p,xdiscretized);

  % Delete values below zero for the final curve for the Active power of the load
    newyfitdiscretized=yfitdiscretized;
r=1;
    for c = 1:ncols

        if  yfitdiscretized(r,c)<0
            newyfitdiscretized(r,c) = 0;
        else
   newyfitdiscretized(r,c)= yfitdiscretized(r,c);
        end
    end
    
    
    % Block RH (Winter)
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
   
     
run('Supervision_Rev3'); % Run the GUI
