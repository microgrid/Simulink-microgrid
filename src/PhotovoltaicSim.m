function Ipv = Photovoltaic(Vpv,Irr,TaC)

%% REFERENCE PAPER:
% Francisco M. González-Longatt, "Model of Photovoltaic Module in
% MatlabTM", II CIBELEC 2005.

%% Solar panel: Suntech STP-280S
% photovoltaic.m function calculates solar array current with a 
% given voltage, irradiance and temperature
% Ipv = photovoltaic array current (function output)
% Vpv = photovoltaic array voltage
% Irr = irradiance (1 Irr = 1000 W/m^2)
% TaC = temperature (in celsius degrees)

%% Constants

k = 1.38e-23;        % Boltzman’s const
q = 1.60e-19;        % charge on an electron
Np = 10;             % Number of solar panels
n = 2;               % Diode quality factor (=2 for crystaline, <2 for amorphous)
Vg = 1.12;           % Band gap voltage, 1.12V for xtal Si, 1.75 for amorphous Si
Ns = 96*Np;          % Number of cells conected in series (96 cells each panel)
T1 = 273 + 25;       % 25C degrees in Kelvin's
Voc_T1 = 44.8*Np/Ns; % Open circuit voltage per cell at T1 temperature
Isc_T1 = 8.33;       % Short circuit current at temperature T1

T2 = 273 + 75;
Voc_T2 = Voc_T1*(-0.34/100*(T2-T1)) /Ns; % Open circuit voltage per cell at temperature T2
Isc_T2 = Isc_T1*(0.05/100*(T2-T1));      % Short circuit current per cell at temperature T2

TaK = 273 + TaC; % Photovoltaic array working temperature
TrK = 273 + 25;  % Reference temperature

%% Calculation of the photocurrent Iph
K0 = (Isc_T2 - Isc_T1)/(T2-T1);          % K0 constant is determined from Isc vs T (ECUATION 4)
Iph_T1 = Isc_T1 * Irr;                   % (ECUATION 3)
Iph = Iph_T1 + K0*(TaK-T1);              % Photocurrent (ECUATION 2)

%% Calculation of saturation current of the diode I0
I0_T1 = Isc_T1/(exp(q*Voc_T1/(n*k*T1))-1);                       % (ECUATION 6)
I0 = I0_T1*(TaK/T1).^(3/n).*exp(-q*Vg/(n*k).*((1./TaK)-(1/T1))); % Diode sat. current

%% Calculation of the series resistance Rs, represents the resistance inside
%  its cell in the connection between cells
Xv = I0_T1*q/(n*k*T1)*exp(q*Voc_T1/(n*k*T1)); % (ECUATION 8)
dVdI_Voc = -1.15/Ns /2;                       % dV/dI at Vco per cell, from manufacturers graph
Rs = -dVdI_Voc - 1/Xv;                        % Resistance per cell (ECUATION 7)

%% Calculation of the PV array current, Ipv
Vt_Ta = n*k*TaK/q;                            % = nkT/q
Vc = Vpv/Ns;
Ipv = zeros(size(Vc));
% Ipv = Iph - I0.*( exp((Vc+Ipv.*Rs)./Vt_Ta) -1) (ECUATION 1);
% Solve for Ipv: f(Ipv) = Iph - Ipv - I0.*( exp((Vc+Ia.*Rs)./Vt_Ta) -1) = 0;
% Newton-Raphson method: Ipv2 = Ipv1 - f(Ipv1)/f’(Ipv1)
for j=1:5;
  Ipv = Ipv - ...
  (Iph - Ipv - I0.*( exp((Vc+Ipv.*Rs)./Vt_Ta) -1))...
  ./ (-1 - (I0.*( exp((Vc+Ipv.*Rs)./Vt_Ta) -1)).*Rs./Vt_Ta);
end