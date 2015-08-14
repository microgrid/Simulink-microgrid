# 24 hours simulation of a microgrid
This is a complete model of a microgrid including the power sources, their power electronics, a load and mains model using MatLab and Simulink. The model is based on Faisal Mohamed's master thesis, Microgrid Modelling and Simulation.

## What is a microgrid
The microgrid simulated use a group of electricity sources and loads to work disconnected from any centralized grid (macrogrid) and function autonomously to provide power to its local area. The simulation models the microgrid at steady state to analyse their transient response to changing input. 

## Purpose of this simulation
Design tools are needed to build the prototype PV-microgrid at the College of Science and Technology in Bhutan. This project will be supporting this Microgrid at CST by proposing a design tool that can
* Identify optimal microgrid structure and composition.
* Give a full year simulation of the system, with measurements on load, production, voltage and frequency.
* Give methods for simplifying the planning and resource-assessment phase.

## How to run
Open the folder simulink-microgrid then open the simulink file 'Microgrid_24h_Simulation.mdl' and in the subfolder src open the file 'main.mat'. You can now, run the 'main.mat' file and follow the instructions (Be careful, you have to open the simulink before you can run the main file). 

## Compiling
The time of the compilation is greatly impacted by the performance of your computer.

## Supported operating systems
Windows, Linux and Mac are supported by this simulation. When you run the 'main.mat' file, a popup box let you choose between different OS.

## Input Data of the simulink
The different inputs data are located in the file simulink-microgrid/database.

## To Do

- [x] The simulation crashes. 
- [ ] Enhance the readme
  * Explain how to run the simulation
  * Write about compiling
  * write about supported operating systems
  * Add usefull links to prior knowledge for this simulation, such as using excel and matlab together.
- [x] Create a GUI in order to control and visualize the simulation
- [x] Make the GUI dynamic
- [ ] Implement the integration of a backup in the simulink
- [ ] Create a wiki
- [x] Testing
  * Run a complete simulation and analyse the results.
- [x] Simulation crashed - find error
- [ ] Add support for multi-core.
- [x] Add OS X support
- [ ] Run simulation on OS X
- [ ] Check the name of the previous master thesis
