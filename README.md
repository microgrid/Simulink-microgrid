# 24 hours simulation of a microgrid
This is a complete model of a microgrid including the power sources, their power electronics, a load and mains model using MatLab and Simulink. The model is based on Faisal Mohamed's master thesis, Microgrid Modelling and Simulation.

## What is a microgrid
The microgrid simulated use a group of electricity sources and loads to work disconnected from any centralized grid (macrogrid) and function autonomously to provide power to its local area. The simulation models the microgrid at steady state to analyse their transient response to changing input. 

## Purpose of this simulation
Design tools are needed to build the prototype PV-microgrid at the College of Science and Technology in Bhutan. This project will be supporting this Microgrid at CST by proposing a design tool that can
* Identify optimal microgrid structure and composition.
* Give a full year simulation of the system, with measurements on load, production, voltage and frequency.
* Give methods for simplifying the planning and resource-assessment phase.

## To Do

- [ ] Enhance the readme
  * Explain how to run the simulation
  * Write about compiling
  * write about supported operating systems
  * Add usefull links to prior knowledge for this simulation, such as using excel and matlab together.
- [x] Create a GUI in order to control and cisualize the simulation
- [x] Make the GUI dynamic
- [ ] Implement the integration of a backup in the simulink
- [ ] Create a wiki
- [ ] Testing
  * Run a complete simulation and analyse the results.
