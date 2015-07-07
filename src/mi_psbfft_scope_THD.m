    function [mag,phase,freq]=mi_psbfft_scope_THD(t,sig_struct,freq_fund,freq_max,nb_cycles,no_input,no_sig)
%%PSBFFT_SCOPE computes and displays spectrum of a signal stored in a Structure with Time
%   format (Format used to save signals in Simulink Scope block and in To Workspace block).
%   The signal must be sampled at fixed step.
%
%   PSBFFT_SCOPE performs Fourier analysis of the NB_CYCLES last cycles of signal. 
%   The analyzed signal and a bar graph of the magnitudes of harmonic components are displayed .
%   Harmonic magnitudes are displayed in percent of one of the following two components:
%     DC component or fundamental component defined by FREQ_FUND.
%   The highest of these two components is chosen as a base value to normalize harmonic contents.  
%   The magnitude of the DC component or fundamental value is written on the spectrum graph.
%   For accurate results, use a sampling time giving an integer number of samples per period.
%
%   Syntax: 5 or 6 input arguments are allowed:
%   [mag,phase,freq]=psbfft_scope(sig_struct, freq_fund, freq_max, nb_cycles, no_input)
%   [mag,phase,freq]=psbfft_scope(sig_struct, freq_fund, freq_max, nb_cycles, no_input, no_sig)
%   
%   input arguments
%   ---------------   
%   sig_struct : name of the structure containing time and signals saved in the Scope
%   freq_fund  : fundamental frequency of signal (Hz)
%   freq_max   : maximum frequency of spectrum to be displayed (Hz)
%   nb_cycles  : number of cycles to analyze 
%   no_input   : scope input number
%   no_sig     : signal number; default=1
%               (to be specified only in case of multiplexed signals on the same scope input)
%
%   output arguments
%   ---------------
%   mag        : vector of magnitudes of harmonics (units of input signal)
%                mag(1)= DC component, mag(nb_cycles+1)=fundamental,...
%                mag(n*nb_cycles+1)= harmonic order n
%   phase      : vector of phases (degrees)
%   freq       : vector of frequencies (Hz)
%
% 
%   See also PSBFFTSCOPE

%   G. Sybille, Hydro-Quebec; IREQ 01-02-2000, 07-02-2001.
%   Copyright 1997-2001 TEQSIM International Inc., under sublicense
%   from Hydro-Quebec, and The MathWorks, Inc.
%   $Revision: 1.6 $


DT=t(2)-t(1);



ncycles=max(t)*freq_fund;
% if ncycles<nb_cycles,
% 	error(sprintf('The signal must contain at least %d cycle(s) of fundamental frequency',nb_cycles))
% end

% format compact;
% fprintf('psbfft_scope is processing input %d; Signal %d ...\n',no_input,no_sig);

nech_cycle=1/freq_fund/DT;
% fprintf('Sampling time = %g s\n',DT)
% fprintf('Number of samples per cycle = %d\n',nech_cycle);
% mat=getfield(sig_struct.signals,{no_input},'values');
% [n,nsig]=size(mat);
% if nsig>1,
%    fprintf('Input %d contains %d signals; Signal %d will be analyzed\n',no_input,nsig,no_sig);
% end

npoints=round(nb_cycles*nech_cycle);
n=length(t);
mat=sig_struct;
t=t(n-npoints+1:n);
V=mat(n-npoints+1:n);


clf; figure(1);
% Plot last cycle of signal to be analyzed
%------------------------------------------
subplot(211)
plot(t,V)
ylabel(sprintf('Signal '));
xlabel('time (s)');
grid

% Compute fft
% -----------
spec_V=2*fft(V)/(npoints);
freq=0:freq_fund/nb_cycles:1/DT;
nfmax=find(freq>=freq_max); nfmax=nfmax(1);
mag=abs(spec_V(1:nfmax));
phase=angle(spec_V(1:nfmax))*180/pi;
freq=freq(1:nfmax);

% Compute THD
% -----------

sef = sqrt(sum(mag.^2) - mag(nb_cycles+1)^2 - mag(1)^2);
THD = sef/mag(nb_cycles+1)*100

% Plot frequency spectrum in % of fundamental
% -------------------------------------------
subplot(212)

% Sort harmonics starting from DC component or fundamental component
if mag(1)==max(mag)
   [mag_sort,nh_sort]=sort(mag(2:nfmax)); %sort harmonics of rank>0 (DC)
   harmo_base=mag(1)/2; % base value to be used for normalization=DC component
   n1=0;
else
   [mag_sort,nh_sort]=sort(mag(nb_cycles+2:nfmax)); %sort harmonics of rank >1 (Fund)
   harmo_base=mag(nb_cycles+1); % base value to be used for normalization=fundamental
   n1=1;
end

% Compute first 2 highest harmonics in % of DC or fundamental
mag_max1=mag_sort(length(nh_sort))/harmo_base*100; % mag of highest harmonic
nh_max1=nh_sort(length(nh_sort))/nb_cycles+n1; % order of first highest harmonic
mag_max2=mag_sort(length(nh_sort)-1)/harmo_base*100; % mag of highest harmonic
nh_max2=nh_sort(length(nh_sort)-1)/nb_cycles+n1; % order of first highest harmonic

% Plot spectrum normalized with respect to fundamental or DC component
% and display first 2 highest values in command window

bar(freq,mag*100/harmo_base,0.25); 
axis([0 freq_max 0 1.1*mag_max1])
if n1==0
   str=sprintf('DC component = %g',harmo_base);
   text(0.05*freq_max,0.95*mag_max1,str)
   ylabel('Mag (% of DC component)');
   fprintf('DC component : %g ; Highest harmonics : Orders=[%d %d] Values=[%4g%% %4g%%]\n\n',...
harmo_base, nh_max1, nh_max2, mag_max1, mag_max2);


else
   str=sprintf('Fundamental (%g Hz)= %g',freq_fund,harmo_base);
   text(0.05*freq_max,0.95*mag_max1,str);
   str=['Mag (% of ',num2str(freq_fund),' Hz component)'];
   ylabel(str);
   fprintf('Fundamental : %g ; Highest harmonics : Orders=[%d %d] Values=[%4g%% %4g%%]\n\n',...
harmo_base, nh_max1, nh_max2, mag_max1, mag_max2);


end
xlabel('Frequency (Hz)');