 function varargout = updategui(varargin) 
 
% Take the data from the simulink %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Time
rtoc = get_param('Microgrid_24h_Simulation/Subsystem/Clock','RuntimeObject');
clock= rtoc.OutputPort(1).Data;
assignin('base', 'clock', clock);
 
% SOC
rto1 = get_param('Microgrid_24h_Simulation/Subsystem/Gain1','RuntimeObject');
SOC= rto1.OutputPort(1).Data;
assignin('base', 'SOC', SOC);
 
% Execute MATLAB expression in specified workspace(Allow visibility for the GUI)
 

% Take the data from the simulink %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Frequency
rto2 = get_param('Microgrid_24h_Simulation/Subsystem/Gain2','RuntimeObject');
F= rto2.OutputPort(1).Data;
assignin('base', 'F', F);

% Take the data from the simulink %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Voltage
rto3 = get_param('Microgrid_24h_Simulation/Subsystem/Gain3','RuntimeObject');
V= rto3.OutputPort(1).Data;
assignin('base', 'V', V);
% 
% %get a handle to the GUI's 'current state' window
% statestxt = findobj('Tag','curState');
% 
% %update the gui
% set(statestxt,'string',str);

  end