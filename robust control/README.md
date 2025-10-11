# Robust Control Example (Robust Control)

This folder contains a Robust Control example for a two-link manipulator. It includes the main script to run the simulation, a Simulink model implementing the control loop, plotting utilities and a helper for manipulator visualization.

Files

- `main.m` — main script that initializes the controller, sets simulation parameters and runs the Simulink model.
- `trace_figures.m` — plotting script used to visualize simulation results (joint variables, torques, errors, trajectories, etc.).
- `robust_control.slx` — Simulink model that implements the robust control loop (open in Simulink to inspect or simulate).
- `helperRobotEnvironment.m` — helper function that draws and animates the manipulator for visualization.

How to run

1. Open MATLAB and set this folder as the current working directory (or add it to the MATLAB path).
2. If necessary, adjust the physical parameters and simulation settings in `main.m` (arm lengths, masses, simulation time, etc.).
3. Run `main.m` from the MATLAB command window. This will run the Simulink model `robust_control.slx` and then execute `trace_figures.m` to display results.

Requirements

- MATLAB (R2019b or newer recommended)
- Simulink
- Control System Toolbox (used by some scripts)
- (Optional) any toolbox required by `robust_control.slx` if the model uses specific blocks or toolboxes.

Notes

- The Simulink `slprj/` folder may be generated when running the model. You can safely delete it to clean up build artifacts.
- The plotting script uses LaTeX interpreters for labels; if fonts or interpreters cause warnings, try switching label interpreters or adjusting font settings.
