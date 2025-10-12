This folder contains a linear Model Predictive Control (MPC) example for a two-joint planar manipulator.

Files
- `StateFcn.m` — Computes the system state derivatives (state function).
- `OutputFcn.m` — Computes the system outputs (output function).
- `JacStateFcn.m` — Returns the linearized state Jacobian (A, B) around an operating point.
- `JacOutputFcn.m` — Returns the output matrix (C) for the linearized system.
- `main.m` — Main script that sets up, linearizes the model and runs the linear MPC simulation.
- `trace_figures.m` — Plotting script to visualize simulation results.
- `helperRobotEnvironment.m` — Utility to draw/visualize the robot manipulator and environment.
- `generateJacobian.m` — Script that builds and saves the Jacobian function handles used by the MPC (`Jacobian.mat`).

Quick start
1. Open MATLAB and set this folder as the current folder or add it to the MATLAB path.
2. (Optional) Regenerate the Jacobian function handles if you changed model parameters or want to re-run symbolics:

```matlab
generateJacobian
```

3. Run the example simulation:

```matlab
main
```

Requirements
- MATLAB (R2019b or later recommended)
- Symbolic Math Toolbox (only required if you run `generateJacobian`)
- Model Predictive Control Toolbox
