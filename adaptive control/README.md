This folder contains an adaptive control example implemented with a Simulink model.

Files
- `main.m` — Initializes controller parameters and reference trajectories, then runs the Simulink model.
- `trace_figures.m` — Plotting script for visualizing simulation results.
- `adaptive_control.slx` — Simulink model implementing the adaptive control loop.
- `helperRobotEnvironment.m` — Utility to draw/visualize the robot manipulator.

Quick start
1. Open MATLAB and set this folder as the current folder or add it to the MATLAB path.
2. Run the `main.m` script to launch the Simulink simulation and generate figures:

```matlab
main
```

Requirements
- MATLAB (R2019b or later recommended)
- Simulink (required to run `adaptive_control.slx`)
