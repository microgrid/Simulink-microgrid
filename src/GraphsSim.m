
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                     %%%
%%%                 SIMULATION VARIABLES GRAPHS                         %%% 
%%%                                                                     %%%   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% All voltages are RED colour
% All currents are BLUE colour
% All powers are BLACK colour

%% PV ARRAY

figure(1) 
% % Irradiance
subplot(4,1,1);
plot(t,Irr,'g','linewidth',2)
grid on
title('Irradiance')
ylabel('[KW/m^2]','fontsize',12)
% PV Array Voltage
subplot(4,1,2);
plot(t,Vpv,'r','linewidth',2)
grid on
title('PV Array Voltage')
ylabel('[V]','fontsize',12)
% PV Array Current
subplot(4,1,3);plot(t,Ipv_array,'b','linewidth',2)
grid on
title('PV Array Current')
ylabel('[A]','fontsize',12)
% PV Array Power
subplot(4,1,4);
plot(t,Ppv/1000,'k','linewidth',2)
grid on
title('PV Array Power')
ylabel('[kW]','fontsize',12)
xlabel('Time [s]','fontsize',12)

%% DCDC BOOST CONVERTER CONTROL

figure(2)
% Reference voltage
subplot(2,1,1);
plot(t,Vref,'r','linewidth',2)
grid on
title('Reference Voltage')
ylabel('[V]','fontsize',12)
% Delta
subplot(2,1,2);
plot(t,delta,'b','linewidth',2)
grid on
title('Delta')
xlabel('Time [s]','fontsize',12)

%% DC BUS PV SIDE

figure(3)
% DC Bus Voltage
subplot(3,1,1);
plot(t,Vbus,'r','linewidth',2)
grid on
title('DC Bus Voltage PV Side')
ylabel('[V]','fontsize',12)
% DC Bus Current
subplot(3,1,2);plot(t,Ibus1,'b','linewidth',2)
grid on
title('DC Bus Current PV Side')
ylabel('[A]','fontsize',12)
% DC Bus  Power
subplot(3,1,3);
plot(t,Pbus/1000,'k','linewidth',2)
grid on
title('DC Bus Power PV Side')
ylabel('[kW]','fontsize',12)
xlabel('Time [s]','fontsize',12)

%%  DC LOAD

figure(4)
% DC Load Voltage
subplot(3,1,1)
plot(t,Vload,'r','linewidth',2)
grid on
title('DC Load Voltage')
ylabel('[V]','fontsize',12)
% DC Load Current
subplot(3,1,2)
plot(t,Iload,'b','linewidth',2)
grid on
title('DC Load Current')
ylabel('[A]','fontsize',12)
% DC Load Power
subplot(3,1,3)
plot(t,Pload/1000,'k','linewidth',2)
grid on
title('DC Load Power')
ylabel('[kW]','fontsize',12)
xlabel('Time [s]','fontsize',12)

%%  DC BUS BATTERY SIDE

figure(5)
% DC to Battery Voltage
subplot(3,1,1)
plot(t,Vdc,'r','linewidth',2)
grid on
title('DC Bus Voltage Battery Side')
ylabel('[V]','fontsize',12)
% DC to Battery Current
subplot(3,1,2)
plot(t,Idc1,'b','linewidth',2)
grid on
title('DC Bus Current Battery Side')
ylabel('[A]','fontsize',12)
% DC to Battery Power
subplot(3,1,3)
plot(t,Pdc/1000,'k','linewidth',2)
grid on
title('DC Bus Power Battery Side')
ylabel('[kW]','fontsize',12)
xlabel('Time [s]','fontsize',12)

%% BATTERY

figure(6)
% Battery SOC
subplot(4,1,1)
plot(t,SOC,'g','linewidth',2)
grid on
title('Battery SOC')
ylabel('[%]','fontsize',12)
% Battery Voltage
subplot(4,1,2)
plot(t,Vbat,'r','linewidth',2)
grid on
title('Battery Voltage')
ylabel('[V]','fontsize',12)
% Battery Current
subplot(4,1,3)
plot(t,Ibat,'b','linewidth',2)
grid on
title('Battery Current')
ylabel('[A]','fontsize',12)
% Battery Power
subplot(4,1,4)
plot(t,Pbat/1000,'k','linewidth',2)
grid on
title('Battery Power')
ylabel('[kW]','fontsize',12)
xlabel('Time [s]','fontsize',12)

%% DCDC BIDIRECTIONAL CONVERTER CONTROL

figure(7) 
% DC Bus Voltage Controller
subplot(2,1,1)
plot(t,Vdc_ref,'r','linewidth',2)
grid on
hold on
plot(t,Vdc,'b','linewidth',2)
ylabel('[V]','fontsize',12)
legend('Reference','Real')
title('DC Bus Controller')
% Battery Current Controller
subplot(2,1,2)
plot(t,Ibat_ref,'r','linewidth',2)
grid on
hold on
plot(t,Ibat,'b','linewidth',2)
ylabel('[A]','fontsize',12)
legend('Reference','Real')
title('Battery Current Controller')
xlabel('Time [s]','fontsize',12)

%% AC LOAD

figure(8)
% AC Load Voltage
subplot(2,1,1);
plot(t,Vab,'r','linewidth',2)
grid on
hold on
plot(t,Vbc,'b','linewidth',2)
hold on
plot(t,Vca,'g','linewidth',2)
title('AC Load Voltage')
ylabel('[V]','fontsize',12)
% AC Load Current
subplot(2,1,2);
plot(t,Ia,'r','linewidth',2)
hold on
plot(t,Ib,'b','linewidth',2)
hold on
plot(t,Ic,'g','linewidth',2)
grid on
title('AC Load Current')
ylabel('[A]','fontsize',12)
xlabel('Time [s]','fontsize',12)

figure(9) 
% Frequency
subplot(2,1,1)
plot(t,f_ref,'r','linewidth',2)
grid on
ylabel('[Hz]','fontsize',12)
title('Frequency Reference')
subplot(2,1,2)
plot(t,fabc_real_fil,'b','linewidth',2)
grid on
ylabel('[Hz]','fontsize',12)
title('Frequency')
xlabel('Time [s]','fontsize',12)

figure(10)
% AC Load Active Power
subplot(2,1,1);
plot(t,Pacload/1000,'k','linewidth',2)
grid on
title('AC Load Active Power')
ylabel('[kW]','fontsize',12)
% AC Load Reactive Power
subplot(2,1,2);
plot(t,Qacload/1000,'k','linewidth',2)
grid on
title('AC Load Reactive Power')
ylabel('[kVAr]','fontsize',12)
xlabel('Time [s]','fontsize',12)

%% INVERTER CONTROL

figure(11) 
% Voltage and frequency references
subplot(2,1,1)
plot(t,Vabc_ref,'r','linewidth',2)
grid on
ylabel('[V]','fontsize',12)
title('Voltage Reference')
subplot(2,1,2)
plot(t,f_ref,'b','linewidth',2)
grid on
ylabel('[Hz]','fontsize',12)
title('Frequency Reference')
xlabel('Time [s]','fontsize',12)

figure(12)
% Voltage Control Loop
subplot(2,1,1)
plot(t,vd,'b','linewidth',2)
grid on
hold on
plot(t,vd_ref,'r','linewidth',2)
ylabel('[V]','fontsize',12)
legend('Real','Reference')
title('Voltage Control Loop D Reference Frame')
subplot(2,1,2)
plot(t,vq,'b','linewidth',2)
grid on
hold on
plot(t,vq_ref,'r','linewidth',2)
ylabel('[V]','fontsize',12)
legend('Real','Reference')
title('Voltage Control Loop Q Reference Frame')
xlabel('Time [s]','fontsize',12)

figure(13)
% Current Control Loop
subplot(2,1,1)
plot(t,id,'b','linewidth',2)
grid on
hold on
plot(t,id_ref,'r','linewidth',2)
ylabel('[A]','fontsize',12)
legend('Real','Reference')
title('Current Control Loop D Reference Frame')
subplot(2,1,2)
plot(t,iq,'b','linewidth',2)
grid on
hold on
plot(t,iq_ref,'r','linewidth',2)
ylabel('[A]','fontsize',12)
legend('Real','Reference')
title('Current Control Loop Q Reference Frame')
xlabel('Time [s]','fontsize',12)

%% DC BUS INVERTER SIDE

figure(14)
% DC Bus Voltage
subplot(3,1,1);
plot(t,Vdcinv1,'r','linewidth',2)
grid on
title('DC Bus Voltage Inverter Side')
ylabel('[V]','fontsize',12)
% DC Bus Current
subplot(3,1,2);plot(t,Idcinv1,'b','linewidth',2)
grid on
title('DC Bus Current Inverter Side')
ylabel('[A]','fontsize',12)
% DC Bus  Power
subplot(3,1,3);
plot(t,Pdcinv1/1000,'k','linewidth',2)
grid on
title('DC Bus Power Inverter Side')
ylabel('[kW]','fontsize',12)
xlabel('Time [s]','fontsize',12)

%% SYSTEM POWERS

figure(15)
% PV Power
subplot(4,1,1);
plot(t,Ppv/1000,'k','linewidth',2)
grid on
title('PV Power')
ylabel('[kW]','fontsize',12)
% Battery Power
subplot(4,1,2);
plot(t,Pbat/1000,'k','linewidth',2)
grid on
title('Battery Power')
ylabel('[kW]','fontsize',12)
% DC Load Power
subplot(4,1,3);
plot(t,Pload/1000,'k','linewidth',2)
grid on
title('DC Load Power')
ylabel('[kW]','fontsize',12)
% AC Load Power
subplot(4,1,4);
plot(t,Pacload/1000,'k','linewidth',2)
grid on
title('AC Load Power')
ylabel('[kW]','fontsize',12)
xlabel('Time [s]','fontsize',12)

%% LOAD POWERS

figure(16)
% DC Load Power
subplot(2,1,1);
plot(t,Pload/1000,'k','linewidth',2)
grid on
title('DC Load Power')
ylabel('[kW]','fontsize',12)
% AC Load Power
subplot(2,1,2);
plot(t,Pacload/1000,'k','linewidth',2)
grid on
title('AC Load Power')
ylabel('[kW]','fontsize',12)
xlabel('Time [s]','fontsize',12)

%% GENERATION POWERS

figure(17)
% PV Power
subplot(2,1,1);
plot(t,Ppv/1000,'k','linewidth',2)
grid on
title('PV Power')
ylabel('[kW]','fontsize',12)
% Battery Power
subplot(2,1,2);
plot(t,Pbat/1000,'k','linewidth',2)
grid on
title('Battery Power')
ylabel('[kW]','fontsize',12)
xlabel('Time [s]','fontsize',12)
