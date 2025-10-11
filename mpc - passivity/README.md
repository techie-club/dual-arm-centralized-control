This folder contains an example of a Model Predictive Control (MPC) setup that integrates passivity constraints.

Files
- `StateFcn.m` — Computes the system state derivatives (state function).
- `OutputFcn.m` — Computes the system outputs (output function).
- `PassivityInput.m` — Defines the input-side passivity vector used by the controller.
- `PassivityOutput.m` — Defines the output-side passivity vector used by the controller.
- `JacStateFcn.m` — Computes Jacobians of the state function (symbolic or numeric wrapper).
- `JacOutputFcn.m` — Computes Jacobians of the output function.
- `ceiling.m` — Constraint function that represents the ceiling (obstacle) constraint.
- `circle.m` — Constraint function that represents a circular obstacle.
- `main.m` — Main script that sets up and runs the control loop / MPC example.
- `trace_figures.m` — Plotting script that visualizes simulation results.
- `helperRobotEnvironment.m` — Utility to draw/visualize the robot manipulator and environment.
- `generateJacobian.m` — Script that builds and saves the Jacobian function handles used by the MPC (`Jacobian.mat`).

Quick start
1. Open MATLAB and add this folder to the path (or set it as the current folder).
2. If needed, run `generateJacobian.m` to regenerate the Jacobian functions (requires Symbolic Math Toolbox):

```matlab
generateJacobian
```

3. Run `main.m` to execute the MPC + passivity example. Adjust parameters inside `main.m` as needed.

Requirements
- MATLAB (R2019b or later recommended)
- Symbolic Math Toolbox (to run `generateJacobian.m`)
- Model Predictive Control Toolbox (used by MPC setup in `main.m`)
